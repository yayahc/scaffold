import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../content/domain/usecases/refresh_contents.dart';

enum SplashStatus { loading, ready }

@injectable
class SplashCubit extends Cubit<SplashStatus> {
  SplashCubit(this._refreshContents) : super(SplashStatus.loading);

  final RefreshContents _refreshContents;

  Future<void> bootstrap() async {
    await _refreshContents(const NoParams());
    if (!isClosed) emit(SplashStatus.ready);
  }
}
