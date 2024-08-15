import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/menu/menu_items.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('yaba'),),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const items = menuItems;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _CustomListTile(item: item,);
      },);
  }
}

class _CustomListTile extends StatelessWidget {
  final MenuItem item;
  const _CustomListTile({super.key, required this.item});

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