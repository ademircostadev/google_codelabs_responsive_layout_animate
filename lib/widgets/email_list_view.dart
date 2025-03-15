import 'package:flutter/material.dart';
import 'package:google_codelabs_responsive_layout_animado/models/models.dart';
import 'package:google_codelabs_responsive_layout_animado/widgets/email_widget.dart';
import 'package:google_codelabs_responsive_layout_animado/models/data.dart' as data;
import 'package:google_codelabs_responsive_layout_animado/widgets/search_bar.dart' as search_bar;

class EmailListView extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  const EmailListView({
    super.key,
    this.selectedIndex,
    this.onSelected,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8.0),
          search_bar.SearchBar(currentUser: currentUser),
          const SizedBox(height: 8.0),
          ...List.generate(
            data.emails.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: EmailWidget(
                  email: data.emails[index],
                  onSelected: onSelected != null
                      ? () {
                          onSelected!(index);
                        }
                      : null,
                  isSelected: selectedIndex == index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
