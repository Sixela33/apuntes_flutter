import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;

  const MenuItem({required this.title, required this.subtitle, required this.icon, required this.link});
}

const List<MenuItem> menuItems = [
  MenuItem(
      title: 'Buttons', 
      subtitle: 'all buttons', 
      icon: Icons.smart_button_outlined, 
      link: '/buttons'
    ),
    MenuItem(
      title: 'Controls', 
      subtitle: 'all controls', 
      icon: Icons.car_rental_outlined, 
      link: '/controls'
    ),
    MenuItem(
      title: 'SnackBar', 
      subtitle: 'all Snack Bars', 
      icon: Icons.car_rental_outlined, 
      link: '/snackBars'
    ),
    MenuItem(
      title: 'Tuturial', 
      subtitle: 'typical tutorial app', 
      icon: Icons.car_rental_outlined, 
      link: '/tutorial'
    ),
    MenuItem(
      title: 'Progress', 
      subtitle: 'progress Items', 
      icon: Icons.car_rental_outlined, 
      link: '/progress'
    ),
    MenuItem(
      title: 'Counter', 
      subtitle: 'pThis is a counter!', 
      icon: Icons.car_rental_outlined, 
      link: '/counter'
    ),
    MenuItem(
      title: 'Theme Selector', 
      subtitle: 'Change your theme', 
      icon: Icons.car_rental_outlined, 
      link: '/Theme'
    ),
];
