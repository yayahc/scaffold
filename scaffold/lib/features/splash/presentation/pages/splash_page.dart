import 'package:flutter/cupertino.dart';
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
        Align(
          alignment: Alignment.center,
          child: CupertinoActivityIndicator(
            color: scheme.onInverseSurface,
          ),
        ),
      ],
    );
  }
}
