import 'package:flutter/material.dart';

import '../../../progress/domain/entities/content_progress.dart';
import '../../domain/entities/content.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    required this.content,
    required this.onTap,
    this.progress,
    super.key,
  });

  final Content content;
  final ContentProgress? progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final unlocked = progress?.unlocked ?? false;
    final isLocked = content.locked && !unlocked;
    final completed = progress?.completed ?? false;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outline),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _Thumb(letter: content.type.name[0].toUpperCase(), locked: isLocked),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _subtitle(content, completed, progress?.bestScore),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _Trailing(isLocked: isLocked, completed: completed),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(Content content, bool completed, double? best) {
    if (completed && best != null) {
      return 'Completed · ${(best * 100).round()}%';
    }
    return content.description ?? content.type.name.toUpperCase();
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.letter, required this.locked});

  final String letter;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: locked ? scheme.surfaceContainerHighest : scheme.inverseSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: locked
          ? Icon(Icons.lock_outline, size: 20, color: scheme.onSurfaceVariant)
          : Text(
              letter,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: scheme.onInverseSurface,
              ),
            ),
    );
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing({required this.isLocked, required this.completed});

  final bool isLocked;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (completed) {
      return Icon(Icons.check_circle, size: 22, color: scheme.onSurface);
    }
    if (isLocked) {
      return Icon(Icons.chevron_right, color: scheme.onSurfaceVariant);
    }
    return Icon(Icons.chevron_right, color: scheme.onSurface);
  }
}
