import 'package:flutter/material.dart';
import 'package:nike_size_selection_ui/core/presentation/constants/constants.dart';
import 'package:nike_size_selection_ui/core/presentation/constants/layout_constants.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < LayoutConstants.screenTablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= LayoutConstants.screenTablet &&
      MediaQuery.of(context).size.width < LayoutConstants.screenDesktop;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= LayoutConstants.screenDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= LayoutConstants.screenDesktop) {
          return desktop;
        } else if (constraints.maxWidth >= LayoutConstants.screenTablet) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
