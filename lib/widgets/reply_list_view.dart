import 'package:flutter/material.dart';
import 'package:google_codelabs_responsive_layout_animado/models/data.dart' as data;
import 'email_widget.dart';

class ReplyListView extends StatelessWidget {
  const ReplyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ...List.generate(
            data.replies.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: EmailWidget(
                  email: data.replies[index],
                  isPreview: false,
                  isThreaded: true,
                  showHeadline: index == 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
