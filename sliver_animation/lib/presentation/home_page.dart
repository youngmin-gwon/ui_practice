import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const _cardHeaderSize = 250.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  final scrollNotifier = ValueNotifier(0.0);
  final headerNotifier = ValueNotifier<_MyHeader?>(null);

  void _onListen() {
    scrollNotifier.value = scrollController.offset;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onListen);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? false;

    if (scrollController.offset > 0 &&
        (headerTitle != title || lastOne != null || headerVisible != visible)) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(
            visible: true,
            title: lastOne,
          );
        } else {
          headerNotifier.value = _MyHeader(
            visible: visible,
            title: title,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                ValueListenableBuilder<double>(
                    valueListenable: scrollNotifier,
                    builder: (context, snapshot, _) {
                      const space = _cardHeaderSize - kToolbarHeight;
                      final percent = lerpDouble(
                        0.0,
                        -pi / 2,
                        (snapshot / space).clamp(0.0, 1.0),
                      );
                      final opacity = lerpDouble(
                        1.0,
                        0.0,
                        (snapshot / space).clamp(0.0, 1.0),
                      );
                      return SliverAppBar(
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        title: const Text(
                          '\$26,710',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        expandedHeight: _cardHeaderSize,
                        stretch: true,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [StretchMode.blurBackground],
                          background: Padding(
                            padding: const EdgeInsets.only(
                              top: kToolbarHeight,
                            ),
                            child: Center(
                              child: Opacity(
                                opacity: opacity!,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.003)
                                    ..rotateX(percent!),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    children: [
                                      Container(
                                        color: Colors.red,
                                        width: 150,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        color: Colors.blue,
                                        width: 150,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle(
                      title: "Latest Transaction",
                      onHeaderChanged: (visible) => _refreshHeader(
                        "April",
                        visible,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text(
                            "Title: $index",
                          ),
                        );
                      },
                      childCount: 15,
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle(
                      title: "March 18",
                      onHeaderChanged: (visible) => _refreshHeader(
                        "March",
                        visible,
                        lastOne: "April",
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text(
                            "Title: $index",
                          ),
                        );
                      },
                      childCount: 15,
                    ),
                  ),
                ],
              ],
            ),
            ValueListenableBuilder<_MyHeader?>(
                valueListenable: headerNotifier,
                builder: (context, snapshot, _) {
                  final visible = snapshot?.visible ?? false;
                  final title = snapshot?.title ?? "";
                  return Positioned(
                      left: 15,
                      top: 0,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        transitionBuilder: (widget, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              child: widget,
                            ),
                          );
                        },
                        child: visible
                            ? DecoratedBox(
                                key: Key(title),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ));
                }),
            const Positioned(
              right: 10,
              top: 0,
              child: CircleAvatar(
                backgroundColor: Color(0xFF1A191D),
                child: Icon(Icons.compare_arrows_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyHeader {
  const _MyHeader({
    required this.visible,
    required this.title,
  });

  final String title;
  final bool visible;
}

const kMaxHeaderTitleHeight = 55.0;

typedef OnHeaderChanged = void Function(bool isVisible);

class _MyHeaderTitle extends SliverPersistentHeaderDelegate {
  final OnHeaderChanged onHeaderChanged;
  final String title;

  const _MyHeaderTitle({
    required this.onHeaderChanged,
    required this.title,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChanged(true);
    } else {
      onHeaderChanged(false);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => kMaxHeaderTitleHeight;

  @override
  double get minExtent => kMaxHeaderTitleHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
