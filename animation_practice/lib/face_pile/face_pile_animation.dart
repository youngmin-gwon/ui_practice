import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FacePilePage extends StatefulWidget {
  const FacePilePage({Key? key}) : super(key: key);

  @override
  _FacePilePageState createState() => _FacePilePageState();
}

class _FacePilePageState extends State<FacePilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: FacePile(
              users: [
                User(
                  id: "fake",
                  firstName: "Matt",
                  avatarUrl: "https://randomuser.me/api/portraits/women/17.jpg",
                ),
                User(
                  id: "fake",
                  firstName: "Matt",
                  avatarUrl: "https://randomuser.me/api/portraits/women/17.jpg",
                ),
                User(
                  id: "fake",
                  firstName: "Matt",
                  avatarUrl: "https://randomuser.me/api/portraits/women/17.jpg",
                ),
              ],
            ),
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final facesCount = widget.users.length;
      final facePercentVisible = 1.0 - widget.facePercentOverlap;

      // how wide?
      final intrinsicWidth = facesCount > 1
          ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize
          : widget.faceSize;

      late double leftOffset;
      if (intrinsicWidth > constraints.maxWidth) {
        leftOffset = 0;
      } else {
        leftOffset = (constraints.maxWidth - intrinsicWidth) / 2;
      }

      return SizedBox(
        height: widget.faceSize,
        child: Stack(
          // shadow 가 stack 밖에 생기기 때문에 잘리게 되기 때문에 clip 없앰
          clipBehavior: Clip.none,
          children: [
            for (var i = 0; i < facesCount; i += 1)
              Positioned(
                //left: leftOffset + (1 * facePercentVisible * widget.faceSize),
                left: leftOffset + (i * facePercentVisible * widget.faceSize),
                top: 0,
                width: widget.faceSize,
                height: widget.faceSize,
                child: AvatarCircle(
                  user: widget.users.first,
                  nameLabelColor: const Color(0xFF222222),
                  backgroundColor: const Color(0xFF888888),
                ),
              ),
          ],
        ),
      );
    });
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
