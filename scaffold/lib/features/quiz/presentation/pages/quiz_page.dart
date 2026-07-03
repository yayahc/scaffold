import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../progress/domain/usecases/record_quiz_attempt.dart';
import '../../domain/entities/quiz.dart';
import '../cubit/quiz_cubit.dart';
import '../widgets/question_view.dart';
import '../widgets/quiz_result_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    required this.quiz,
    required this.title,
    required this.contentId,
    super.key,
  });

  final Quiz quiz;
  final String title;
  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QuizCubit(
            quiz: quiz,
            contentId: contentId,
            recordAttempt: getIt<RecordQuizAttempt>(),
          ),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state.isFinished) {
              return QuizResultView(result: state.result!);
            }
            final cubit = context.read<QuizCubit>();
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${state.index + 1} of ${state.quiz.questions.length}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: QuestionView(
                      question: state.currentQuestion,
                      selected: state.answers[state.currentQuestion.id],
                      onChanged: (value) =>
                          cubit.answer(state.currentQuestion.id, value),
                    ),
                  ),
                  Row(
                    children: [
                      if (state.index > 0)
                        TextButton(
                          onPressed: cubit.previous,
                          child: const Text('Back'),
                        ),
                      const Spacer(),
                      FilledButton(
                        onPressed: state.isLastQuestion
                            ? cubit.submit
                            : cubit.next,
                        child: Text(state.isLastQuestion ? 'Submit' : 'Next'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
