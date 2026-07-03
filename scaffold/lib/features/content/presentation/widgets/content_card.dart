import 'package:flutter/material.dart';

import '../../domain/entities/content.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    required this.content,
    required this.onTap,
    super.key,
  });

  final Content content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(child: Text(content.type.name[0].toUpperCase())),
        title: Text(content.title),
        subtitle: content.description != null ? Text(content.description!) : null,
        trailing: content.locked ? const Icon(Icons.lock_outline) : null,
        onTap: onTap,
      ),
    );
  }
}
