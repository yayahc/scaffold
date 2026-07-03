import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../cubit/content_list_cubit.dart';
import '../widgets/content_card.dart';

class ContentListPage extends StatelessWidget {
  const ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContentListCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Library')),
        body: BlocBuilder<ContentListCubit, ContentListState>(
          builder: (context, state) {
            switch (state.status) {
              case ContentListStatus.initial:
              case ContentListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ContentListStatus.failure:
                return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
              case ContentListStatus.success:
                if (state.contents.isEmpty) {
                  return const Center(child: Text('No content yet'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.contents.length,
                  itemBuilder: (context, i) {
                    final content = state.contents[i];
                    return ContentCard(
                      content: content,
                      progress: state.progress[content.id],
                      onTap: () async {
                        await context.push('/content/${content.id}');
                        // Reflect any progress made while inside the item.
                        if (context.mounted) {
                          context.read<ContentListCubit>().load();
                        }
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
