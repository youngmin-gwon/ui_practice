import 'package:flutter/material.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/routers/routes.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:flutter_web/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
        color: light,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      SizedBox(width: _width / 48),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset("icons/logo.png"),
                      ),
                      const Flexible(
                          child: CustomText(
                        text: "Dash",
                        size: 20,
                        fontWeight: FontWeight.bold,
                        color: active,
                      )),
                      SizedBox(width: _width / 48),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            Divider(color: lightGray.withOpacity(.1)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                      itemName: itemName == authenticationPageRoute
                          ? "Log Out"
                          : itemName,
                      onTap: () {
                        if (itemName == authenticationPageRoute) {
                          // TODO: go to authentication page

                        }
                        if (!menuController.isActive(itemName)) {
                          menuController.chageActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(itemName);
                        }
                      }))
                  .toList(),
            )
          ],
        ));
  }
}
