import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FacePilePractice extends StatefulWidget {
  const FacePilePractice({Key? key}) : super(key: key);

  @override
  _FacePilePracticeState createState() => _FacePilePracticeState();
}

class _FacePilePracticeState extends State<FacePilePractice> {
  final _facePileUsers = <User>[];

  void _addUserToPile() {
    setState(() {
      _facePileUsers.add(
        User(
          id: "${Random().nextInt(10000)}",
          firstName: "Matt",
          imageUrl:
              "https://randomuser.me/api/portraits/women/${Random().nextInt(100)}.jpg",
        ),
      );
    });
  }

  void _removeUserFromPile() {
    if (_facePileUsers.isNotEmpty) {
      setState(() {
        final randomIndex = Random().nextInt(_facePileUsers.length);
        _facePileUsers.removeAt(randomIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: FacePile(
              users: _facePileUsers,
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: "1",
            onPressed: _removeUserFromPile,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 24),
          FloatingActionButton.small(
            heroTag: "2",
            onPressed: _addUserToPile,
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
  void didUpdateWidget(covariant FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncUsersWithPile();
  }

  void _syncUsersWithPile() {
    final newUsers = widget.users.where(
      (user) =>
          _visibleUsers.where((visibleUser) => user == visibleUser).isEmpty,
    );
    _visibleUsers.addAll(newUsers);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final faceCounts = _visibleUsers.length;

      double facePercentVisible = 1.0 - widget.facePercentOverlap;

      final intrinsicWidth = faceCounts > 1
          ? widget.faceSize * (1 + ((faceCounts - 1) * facePercentVisible))
          : widget.faceSize;

      late double leftOffset;
      if (intrinsicWidth > constraints.maxWidth) {
        leftOffset = 0;
        facePercentVisible =
            ((constraints.maxWidth / widget.faceSize) - 1) / (faceCounts - 1);
      } else {
        leftOffset = (constraints.maxWidth - intrinsicWidth) / 2;
      }

      return SizedBox(
        height: widget.faceSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            for (var i = 0; i < faceCounts; i++)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                top: 0,
                left: leftOffset + i * facePercentVisible * widget.faceSize,
                child: AppearingAndDisappearingFace(
                  user: _visibleUsers[i],
                  showFace: widget.users.contains(_visibleUsers[i]),
                  onDisappear: () {
                    setState(() {
                      _visibleUsers.remove(_visibleUsers[i]);
                    });
                  },
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
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppearingAndDisappearingFace oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncScaleAnimationWithWidget();
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
      child: AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AvatarCircle(
          user: widget.user,
          nameLabelColor: const Color(0xFF222222),
          backgroundColor: const Color(0xFF888888),
        ),
      ),
    );
  }
}

class AvatarCircle extends StatefulWidget {
  const AvatarCircle({
    Key? key,
    required this.user,
    this.size = 48,
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
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(widget.user.firstName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8,
                  color: widget.nameLabelColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.user.imageUrl,
            fadeInDuration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

class User {
  const User({
    required this.id,
    required this.firstName,
    required this.imageUrl,
  });

  final String id;
  final String firstName;
  final String imageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) &&
      other is User &&
      runtimeType == other.runtimeType &&
      id == other.id;

  @override
  int get hashCode => id.hashCode;
}
