import 'package:flutter/material.dart';

import 'navigation.dart';
enum AppBarType {
  normal,
  withBack,
  search,
}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType type;

  const CustomAppBar({
    super.key,
    required this.title,
    this.type = AppBarType.normal,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: _buildLeading(),
      actions: _buildActions(context),
    );
  }

  Widget? _buildLeading() {
    switch (type) {
      case AppBarType.withBack:
        return const BackButton();

      case AppBarType.normal:
      case AppBarType.search:
        return null;
    }
  }

  List<Widget>? _buildActions(BuildContext context) {
    switch (type) {
      case AppBarType.search:
        return [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigation.popScreen(context);
            },
          )
        ];

      case AppBarType.normal:
      case AppBarType.withBack:
        return null;
    }
  }

}