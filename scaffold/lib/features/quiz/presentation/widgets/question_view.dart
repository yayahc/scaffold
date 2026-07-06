import 'package:flutter/material.dart';

import '../../domain/entities/question.dart';

const _green = Color(0xFF16A34A);
const _red = Color(0xFFDC2626);

class QuestionView extends StatelessWidget {
  const QuestionView({
    required this.question,
    required this.selected,
    required this.revealed,
    required this.onChanged,
    super.key,
  });

  final Question question;
  final Object? selected;
  final bool revealed;
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
              correct: o.correct,
              multi: false,
              revealed: revealed,
              onTap: () => onChanged(o.id),
            ),
        ],
      MultiChoiceQuestion(:final options) => [
          for (final o in options)
            _OptionTile(
              label: o.label,
              selected: (selected as Set<String>?)?.contains(o.id) ?? false,
              correct: o.correct,
              multi: true,
              revealed: revealed,
              onTap: () {
                final set = Set<String>.from(selected as Set<String>? ?? {});
                set.contains(o.id) ? set.remove(o.id) : set.add(o.id);
                onChanged(set);
              },
            ),
        ],
      TrueFalseQuestion(:final answer) => [
          _OptionTile(
            label: 'True',
            selected: (selected as bool?) == true,
            correct: answer == true,
            multi: false,
            revealed: revealed,
            onTap: () => onChanged(true),
          ),
          _OptionTile(
            label: 'False',
            selected: (selected as bool?) == false,
            correct: answer == false,
            multi: false,
            revealed: revealed,
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
    required this.correct,
    required this.multi,
    required this.revealed,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool correct;
  final bool multi;
  final bool revealed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    Color? status;
    if (revealed) {
      if (correct) {
        status = _green;
      } else if (selected) {
        status = _red;
      }
    }

    final Color background;
    final Color border;
    final Color foreground;
    if (status != null) {
      background = status.withValues(alpha: 0.12);
      border = status;
      foreground = status;
    } else if (revealed) {
      background = scheme.surface;
      border = scheme.outline;
      foreground = scheme.onSurfaceVariant;
    } else if (selected) {
      background = scheme.inverseSurface;
      border = scheme.inverseSurface;
      foreground = scheme.onInverseSurface;
    } else {
      background = scheme.surface;
      border = scheme.outline;
      foreground = scheme.onSurface;
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: revealed ? null : onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: border,
              width: (selected || status != null) ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: foreground,
                    fontWeight: (selected || status != null)
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _Indicator(
                selected: selected,
                multi: multi,
                status: status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.selected,
    required this.multi,
    required this.status,
  });

  final bool selected;
  final bool multi;
  final Color? status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (status != null) {
      final wrong = status == _red;
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(color: status, shape: BoxShape.circle),
        child: Icon(
          wrong ? Icons.close : Icons.check,
          size: 16,
          color: Colors.white,
        ),
      );
    }

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
