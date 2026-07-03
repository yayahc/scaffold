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
    final prompt = Text(
      question.prompt,
      style: Theme.of(context).textTheme.titleLarge,
    );

    return switch (question) {
      SingleChoiceQuestion(:final options) => _Choices(
          prompt: prompt,
          child: Column(
            children: [
              for (final o in options)
                RadioListTile<String>(
                  value: o.id,
                  groupValue: selected as String?,
                  title: Text(o.label),
                  onChanged: (v) => onChanged(v),
                ),
            ],
          ),
        ),
      MultiChoiceQuestion(:final options) => _Choices(
          prompt: prompt,
          child: Column(
            children: [
              for (final o in options)
                CheckboxListTile(
                  value: (selected as Set<String>?)?.contains(o.id) ?? false,
                  title: Text(o.label),
                  onChanged: (checked) {
                    final set = Set<String>.from(selected as Set<String>? ?? {});
                    checked == true ? set.add(o.id) : set.remove(o.id);
                    onChanged(set);
                  },
                ),
            ],
          ),
        ),
      TrueFalseQuestion() => _Choices(
          prompt: prompt,
          child: Column(
            children: [
              RadioListTile<bool>(
                value: true,
                groupValue: selected as bool?,
                title: const Text('True'),
                onChanged: (v) => onChanged(v),
              ),
              RadioListTile<bool>(
                value: false,
                groupValue: selected as bool?,
                title: const Text('False'),
                onChanged: (v) => onChanged(v),
              ),
            ],
          ),
        ),
    };
  }
}

class _Choices extends StatelessWidget {
  const _Choices({required this.prompt, required this.child});

  final Widget prompt;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [prompt, const SizedBox(height: 16), child],
    );
  }
}
