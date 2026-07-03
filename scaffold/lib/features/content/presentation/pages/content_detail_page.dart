import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaffold/core/di/di.dart';

import '../../../quiz/domain/entities/quiz.dart';
import '../../../quiz/presentation/pages/quiz_page.dart';
import '../../domain/entities/content.dart';
import '../../domain/entities/content_type.dart';
import '../cubit/content_detail_cubit.dart';
import '../widgets/unlock_gate.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ContentDetailCubit>()..load(id),
      child: Scaffold(
        body: BlocBuilder<ContentDetailCubit, ContentDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case ContentDetailStatus.initial:
              case ContentDetailStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ContentDetailStatus.failure:
                return Center(child: Text(state.errorMessage ?? 'Error'));
              case ContentDetailStatus.success:
                final content = state.content!;
                if (!state.unlocked) {
                  return UnlockGate(
                    title: content.title,
                    onSubmit: (code) =>
                        context.read<ContentDetailCubit>().tryUnlock(code),
                  );
                }
                return _renderer(content);
            }
          },
        ),
      ),
    );
  }

  Widget _renderer(Content content) {
    return switch (content.type) {
      ContentType.quiz => QuizPage(
          contentId: content.id,
          title: content.title,
          quiz: Quiz.fromPayload(content.payload),
        ),
    };
  }
}
