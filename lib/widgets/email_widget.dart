import 'package:flutter/material.dart';
import 'package:google_codelabs_responsive_layout_animado/models/models.dart';
import 'package:google_codelabs_responsive_layout_animado/widgets/star_button.dart';

enum EmailType {
  preview,
  threaded,
  primaryThreaded,
}

class EmailWidget extends StatefulWidget {
  final bool isSelected, isPreview, showHeadline, isThreaded;
  final Email email;
  final void Function()? onSelected;

  const EmailWidget({
    super.key,
    this.isSelected = false,
    this.isPreview = true,
    this.isThreaded = false,
    this.showHeadline = false,
    required this.email,
    this.onSelected,
  });

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late Color unselectedColor = Color.alphaBlend(
    _colorScheme.primary.withOpacity(0.08),
    _colorScheme.surface,
  );

  Color get _surfaceColor => switch (widget) {
    EmailWidget(isPreview: false) => _colorScheme.surface,
    EmailWidget(isSelected: true) => _colorScheme.primaryContainer,
    _ => unselectedColor,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected,
      child: Card(
        elevation: 0,
        color: _surfaceColor,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showHeadline) ...[
              EmailHeadline(
                email: widget.email,
                isSelected: widget.isSelected,
              ),
            ],
            EmailContent(
              email: widget.email,
              isPreview: widget.isPreview,
              isThreaded: widget.isThreaded,
              isSelected: widget.isSelected,
            )
          ],
        ),
      ),
    );
  }
}

class EmailContent extends StatefulWidget {
  final bool isPreview, isThreaded, isSelected;
  final Email email;

  const EmailContent(
      {super.key,
        required this.isPreview,
        required this.isThreaded,
        required this.isSelected,
        required this.email});

  @override
  State<EmailContent> createState() => _EmailContentState();
}

class _EmailContentState extends State<EmailContent> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  Widget get contentSpacer => SizedBox(height: widget.isThreaded ? 20 : 2);

  String get lastActiveLabel {
    final DateTime now = DateTime.now();
    if (widget.email.sender.lastActive.isAfter(now)) throw ArgumentError();
    final Duration elapsedTime = widget.email.sender.lastActive.difference(now).abs();
    return switch (elapsedTime) {
      Duration(inSeconds: < 60) => '${elapsedTime.inSeconds}s',
      Duration(inMinutes: < 60) => '${elapsedTime.inMinutes}m',
      Duration(inHours: < 24) => '${elapsedTime.inHours}h',
      Duration(inDays: < 365) => '${elapsedTime.inDays}d',
      _ => '${elapsedTime.inDays ~/ 365}y',
    };
  }

  TextStyle? get contentTextStyle => switch (widget) {
    EmailContent(isThreaded: true) => _textTheme.bodyLarge,
    EmailContent(isSelected: true) => _textTheme.bodyMedium
        ?.copyWith(color: _colorScheme.onPrimaryContainer),
    _ => _textTheme.bodyMedium?.copyWith(color: _colorScheme.onSurfaceVariant)
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (constraints.maxWidth - 200 > 0) ...[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.email.sender.avatarUrl),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                  ),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.email.sender.name.fullName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium
                            ?.copyWith(color: _colorScheme.onSecondaryContainer)
                            : _textTheme.labelMedium?.copyWith(
                          color: _colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        lastActiveLabel,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium
                            ?.copyWith(color: _colorScheme.onSecondaryContainer)
                            : _textTheme.labelMedium?.copyWith(
                          color: _colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (constraints.maxWidth - 200 > 0) ...[
                  const StarButton(),
                ]
              ],
            );
          }),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isPreview) ...[
                Text(
                  widget.email.subject,
                  style: const TextStyle(fontSize: 18).copyWith(color: _colorScheme.onSurface),
                ),
              ],
              if (widget.isThreaded) ...[
                contentSpacer,
                Text(
                  'To ${widget.email.recipients.map((recipient) => recipient.name.first).join(', ')}',
                  style: _textTheme.bodyMedium,
                ),
              ],
              contentSpacer,
              Text(
                widget.email.content,
                maxLines: widget.isPreview ? 2 : 100,
                overflow: TextOverflow.ellipsis,
                style: contentTextStyle,
              ),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          widget.email.attachments.isNotEmpty
              ? Container(
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.email.attachments.first.url),
              ),
            ),
          )
              : const SizedBox.shrink(),
          if (!widget.isPreview) ...[
            const EmailReplyOptions(),
          ],
        ],
      ),
    );
  }
}

class EmailHeadline extends StatefulWidget {
  final Email email;
  final bool isSelected;

  const EmailHeadline({
    super.key,
    required this.email,
    required this.isSelected,
  });

  @override
  State<EmailHeadline> createState() => _EmailHeadlineState();
}

class _EmailHeadlineState extends State<EmailHeadline> {
  late final TextTheme _textTheme = Theme.of(context).textTheme;
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 64,
        color: Color.alphaBlend(_colorScheme.primary.withOpacity(0.05), _colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.email.subject,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${widget.email.replies.toString()} Messages',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: _textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (constraints.maxWidth - 200 > 0) ...[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: _colorScheme.surface,
                    child: const Icon(Icons.delete_outline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: _colorScheme.surface,
                      elevation: 0,
                      child: const Icon(Icons.more_vert),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      );
    });
  }
}

class EmailReplyOptions extends StatefulWidget {
  const EmailReplyOptions({super.key});

  @override
  State<EmailReplyOptions> createState() => _EmailReplyOptionsState();
}

class _EmailReplyOptionsState extends State<EmailReplyOptions> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 100) {
          return const SizedBox.shrink();
        }
        return Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(_colorScheme.onInverseSurface)),
                onPressed: () {},
                child: Text(
                  'Reply',
                  style: TextStyle(color: _colorScheme.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_colorScheme.onInverseSurface),
                ),
                onPressed: () {},
                child: Text(
                  'Reply All',
                  style: TextStyle(color: _colorScheme.onSurfaceVariant),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
