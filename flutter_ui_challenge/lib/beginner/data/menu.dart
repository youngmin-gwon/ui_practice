import 'package:flutter/material.dart';

final mockMenuData = [
  Menu(icon: Icons.camera, label: "Memories"),
  Menu(icon: Icons.favorite, label: "Favorites"),
  Menu(icon: Icons.present_to_all, label: "Presents"),
  Menu(icon: Icons.people, label: "Friends"),
  Menu(icon: Icons.emoji_events, label: "Acievement"),
  Menu(icon: Icons.settings, label: "Settings"),
  Menu(icon: Icons.document_scanner, label: "Test"),
  Menu(icon: Icons.person, label: "Developers"),
];

class Menu {
  final IconData icon;
  final String label;
  Menu({
    required this.icon,
    required this.label,
  });
}
