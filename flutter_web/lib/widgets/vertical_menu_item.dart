import 'package:flutter/material.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const VerticalMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? lightGray.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 3,
                    height: 72,
                    color: dark,
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuController.returnIconFor(itemName),
                    ),
                    if (!menuController.isActive(itemName))
                      Flexible(
                          child: CustomText(
                              text: itemName,
                              color: menuController.isHovering(itemName)
                                  ? dark
                                  : lightGray))
                    else
                      Flexible(
                          child: CustomText(
                        text: itemName,
                        color: dark,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ))
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
