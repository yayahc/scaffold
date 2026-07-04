import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/di.dart';
import '../cubit/content_list_cubit.dart';
import '../widgets/content_card.dart';

class ContentListPage extends StatelessWidget {
  const ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ContentListCubit>()..load(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ContentListCubit, ContentListState>(
            builder: (context, state) {
              switch (state.status) {
                case ContentListStatus.initial:
                case ContentListStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case ContentListStatus.failure:
                  return _Message(
                    icon: Icons.wifi_off_rounded,
                    title: 'Something went wrong',
                    subtitle: state.errorMessage ?? 'Please try again.',
                  );
                case ContentListStatus.success:
                  if (state.contents.isEmpty) {
                    return const _Message(
                      icon: Icons.library_books_outlined,
                      title: 'Nothing here yet',
                      subtitle: 'New content will appear here.',
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: _Header()),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                        sliver: SliverList.separated(
                          itemCount: state.contents.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, i) {
                            final content = state.contents[i];
                            return ContentCard(
                              content: content,
                              progress: state.progress[content.id],
                              onTap: () async {
                                await context.push('/content/${content.id}');
                                if (context.mounted) {
                                  context.read<ContentListCubit>().load();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Library', style: theme.textTheme.displaySmall),
          const SizedBox(height: 4),
          Text('Pick up where you left off', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
