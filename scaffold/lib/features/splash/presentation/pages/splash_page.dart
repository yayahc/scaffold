import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/di.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SplashCubit>()..bootstrap(),
      child: BlocListener<SplashCubit, SplashStatus>(
        listenWhen: (_, current) => current == SplashStatus.ready,
        listener: (context, _) => context.goNamed('library'),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          body: _SplashBody(),
        ),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: scheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                child: Text(
                  'S',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: scheme.inverseSurface,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Scaffold',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: scheme.onInverseSurface,
                    ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: scheme.onInverseSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
