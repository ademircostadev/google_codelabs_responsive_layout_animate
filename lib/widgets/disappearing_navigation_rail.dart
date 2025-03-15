import 'package:flutter/material.dart';
import 'package:google_codelabs_responsive_layout_animado/animations.dart';
import 'package:google_codelabs_responsive_layout_animado/destinations.dart';
import 'package:google_codelabs_responsive_layout_animado/transitions/nav_rail_transitions.dart';
import 'package:google_codelabs_responsive_layout_animado/widgets/animated_floating_action_button.dart';

class DisappearingNavigationRail extends StatelessWidget {
  final RailAnimation railAnimation;
  final RailFabAnimation railFabAnimation;
  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  const DisappearingNavigationRail({
    super.key,
    required this.railAnimation,
    required this.railFabAnimation,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
        selectedIndex: selectedIndex,
        backgroundColor: backgroundColor,
        onDestinationSelected: onDestinationSelected,
        leading: Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            const SizedBox(height: 8),
            AnimatedFloatingActionButton(
              animation: railFabAnimation,
              elevation: 0,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
        groupAlignment: -0.85,
        destinations: destinations.map(
          (d) {
            return NavigationRailDestination(
              icon: Icon(d.icon),
              label: Text(d.label),
            );
          },
        ).toList(),
      ),
    );
  }
}
