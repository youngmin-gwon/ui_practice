import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FacePilePage extends StatefulWidget {
  const FacePilePage({Key? key}) : super(key: key);

  @override
  _FacePilePageState createState() => _FacePilePageState();
}

class _FacePilePageState extends State<FacePilePage> {
  final _facePileUser = <User>[];

  void _addUserToPile() {
    setState(() {
      _facePileUser.add(
        User(
          id: "${Random().nextInt(10000)}",
          firstName: "Matt",
          avatarUrl: "https://randomuser.me/api/portraits/women/17.jpg",
        ),
      );
    });
  }

  void _removeUserFromPile() {
    if (_facePileUser.isNotEmpty) {
      setState(() {
        final randomIndex = Random().nextInt(_facePileUser.length);
        _facePileUser.removeAt(randomIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: FacePile(
            users: _facePileUser,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: _removeUserFromPile,
            mini: true,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 24,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: _addUserToPile,
            mini: true,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class FacePile extends StatefulWidget {
  const FacePile({
    Key? key,
    required this.users,
    this.faceSize = 48,
    this.facePercentOverlap = 0.1,
  }) : super(key: key);

  final List<User> users;
  final double faceSize;
  final double facePercentOverlap;

  @override
  _FacePileState createState() => _FacePileState();
}

class _FacePileState extends State<FacePile> {
  final _visibleUsers = <User>[];

  @override
  void initState() {
    super.initState();
    _syncUsersWithPile();
  }

  @override
  void didUpdateWidget(FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncUsersWithPile();
  }

  void _syncUsersWithPile() {
    final newUsers = widget.users.where(
      (user) => _visibleUsers
          .where(
            (visibleUser) => visibleUser == user,
          )
          .isEmpty,
    );

    _visibleUsers.addAll(newUsers);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final facesCount = _visibleUsers.length;
      double facePercentVisible = 1.0 - widget.facePercentOverlap;

      // how wide?
      final intrinsicWidth = facesCount > 1
          ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize
          : widget.faceSize;

      late double leftOffset;
      if (intrinsicWidth > constraints.maxWidth) {
        leftOffset = 0;
        facePercentVisible =
            ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
      } else {
        leftOffset = (constraints.maxWidth - intrinsicWidth) / 2;
      }

      return SizedBox(
        height: widget.faceSize,
        child: Stack(
          // shadow 가 stack 밖에 생기기 때문에 잘리게 되기 때문에 clip 없앰
          clipBehavior: Clip.none,
          children: [
            for (var i = 0; i < _visibleUsers.length; i += 1)
              AnimatedPositioned(
                key: ValueKey(_visibleUsers[i].id),
                left: leftOffset + (i * facePercentVisible * widget.faceSize),
                top: 0,
                width: widget.faceSize,
                height: widget.faceSize,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: AppearingAndDisappearingFace(
                  onDisappear: () {
                    setState(() {
                      _visibleUsers.remove(_visibleUsers[i]);
                    });
                  },
                  user: _visibleUsers[i],
                  showFace: widget.users.contains(_visibleUsers[i]),
                  faceSize: widget.faceSize,
                ),
              ),
          ],
        ),
      );
    });
  }
}

class AppearingAndDisappearingFace extends StatefulWidget {
  const AppearingAndDisappearingFace({
    Key? key,
    required this.user,
    this.faceSize = 48,
    required this.showFace,
    required this.onDisappear,
  }) : super(key: key);
  final User user;
  final double faceSize;
  final bool showFace;
  final VoidCallback onDisappear;

  @override
  _AppearingAndDisappearingFaceState createState() =>
      _AppearingAndDisappearingFaceState();
}

class _AppearingAndDisappearingFaceState
    extends State<AppearingAndDisappearingFace>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onDisappear.call();
        }
      });

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimationWithWidget();
  }

  @override
  void didUpdateWidget(AppearingAndDisappearingFace oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimationWithWidget();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _syncScaleAnimationWithWidget() {
    if (widget.showFace &&
        !_scaleController.isCompleted &&
        _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.faceSize,
      height: widget.faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: AvatarCircle(
            user: widget.user,
            size: widget.faceSize,
            nameLabelColor: const Color(0xFF222222),
            backgroundColor: const Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}

class AvatarCircle extends StatefulWidget {
  const AvatarCircle({
    Key? key,
    required this.user,
    this.size = 48.0,
    required this.nameLabelColor,
    required this.backgroundColor,
  }) : super(key: key);

  final User user;
  final double size;
  final Color nameLabelColor;
  final Color backgroundColor;

  @override
  _AvatarCircleState createState() => _AvatarCircleState();
}

class _AvatarCircleState extends State<AvatarCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        children: [
          Center(
            child: Text(
              widget.user.firstName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.nameLabelColor,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.user.avatarUrl,
            fadeInDuration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String avatarUrl;

  const User({
    required this.id,
    required this.firstName,
    required this.avatarUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
