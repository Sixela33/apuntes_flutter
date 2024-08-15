import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/menu/menu_items.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeScreen();
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    const items = menuItems;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _CustomLitTile(item: item,);
      },
    );
  }
}

class _CustomLitTile extends StatelessWidget {
  final MenuItem item;
  const _CustomLitTile({
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      leading: Icon(item.icon),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        context.push(item.link);
      },
    );
  }
}