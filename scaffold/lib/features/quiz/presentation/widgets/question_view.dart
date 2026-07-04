import 'package:flutter/material.dart';

import '../../domain/entities/question.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({
    required this.question,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final Question question;
  final Object? selected;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prompt = Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(question.prompt, style: theme.textTheme.titleLarge),
    );

    final options = switch (question) {
      SingleChoiceQuestion(:final options) => [
          for (final o in options)
            _OptionTile(
              label: o.label,
              selected: (selected as String?) == o.id,
              multi: false,
              onTap: () => onChanged(o.id),
            ),
        ],
      MultiChoiceQuestion(:final options) => [
          for (final o in options)
            _OptionTile(
              label: o.label,
              selected: (selected as Set<String>?)?.contains(o.id) ?? false,
              multi: true,
              onTap: () {
                final set = Set<String>.from(selected as Set<String>? ?? {});
                set.contains(o.id) ? set.remove(o.id) : set.add(o.id);
                onChanged(set);
              },
            ),
        ],
      TrueFalseQuestion() => [
          _OptionTile(
            label: 'True',
            selected: (selected as bool?) == true,
            multi: false,
            onTap: () => onChanged(true),
          ),
          _OptionTile(
            label: 'False',
            selected: (selected as bool?) == false,
            multi: false,
            onTap: () => onChanged(false),
          ),
        ],
    };

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        prompt,
        for (final tile in options) ...[tile, const SizedBox(height: 12)],
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.multi,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool multi;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: selected ? scheme.inverseSurface : scheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? scheme.inverseSurface : scheme.outline,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: selected ? scheme.onInverseSurface : scheme.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _Indicator(selected: selected, multi: multi),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.selected, required this.multi});

  final bool selected;
  final bool multi;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: selected ? scheme.onInverseSurface : Colors.transparent,
        shape: multi ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: multi ? BorderRadius.circular(7) : null,
        border: Border.all(
          color: selected ? scheme.onInverseSurface : scheme.outline,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(Icons.check, size: 16, color: scheme.inverseSurface)
          : null,
    );
  }
}
