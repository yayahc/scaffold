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
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(child: Text(content.type.name[0].toUpperCase())),
        title: Text(content.title),
        subtitle: content.description != null
            ? Text(content.description!)
            : null,
        trailing: _trailing(context),
        onTap: onTap,
      ),
    );
  }

  Widget? _trailing(BuildContext context) {
    // Still locked → padlock takes priority.
    final unlocked = progress?.unlocked ?? false;
    if (content.locked && !unlocked) {
      return const Icon(Icons.lock_outline);
    }
    // Completed → show a check and the best score.
    if (progress?.completed ?? false) {
      final best = progress?.bestScore;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (best != null) Text('${(best * 100).round()}%'),
          const SizedBox(width: 4),
          Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
        ],
      );
    }
    return null;
  }
}
