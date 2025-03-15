import 'package:flutter/material.dart';

class Destinations {
  final IconData icon;
  final String label;

  Destinations(this.icon, this.label);
}

List<Destinations> destinations = <Destinations>[
  Destinations(Icons.inbox_rounded, 'Inbox'),
  Destinations(Icons.article_outlined, 'Articles'),
  Destinations(Icons.messenger_outline_rounded, 'Messages'),
  Destinations(Icons.group_outlined, 'Groups'),

];