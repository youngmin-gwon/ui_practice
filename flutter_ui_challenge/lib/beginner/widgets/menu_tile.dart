import 'package:flutter/material.dart';

import 'package:flutter_ui_challenge/beginner/data/menu.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFA226CE),
                    Color(0xFF691ADD),
                  ],
                  begin: FractionalOffset(0.0, 1.0),
                  end: FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )),
            child: Icon(
              menu.icon,
              color: Colors.white,
            )),
        title: Text(menu.label),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
