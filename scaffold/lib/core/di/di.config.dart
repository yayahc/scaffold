// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/content/data/datasources/content_local_datasource.dart'
    as _i518;
import '../../features/content/data/datasources/content_remote_datasource.dart'
    as _i321;
import '../../features/content/data/repositories/content_repository_impl.dart'
    as _i463;
import '../../features/content/domain/repositories/content_repository.dart'
    as _i1027;
import '../../features/content/domain/usecases/get_content_by_id.dart' as _i569;
import '../../features/content/domain/usecases/get_contents.dart' as _i458;
import '../../features/content/domain/usecases/refresh_contents.dart' as _i772;
import '../../features/content/presentation/cubit/content_detail_cubit.dart'
    as _i1015;
import '../../features/content/presentation/cubit/content_list_cubit.dart'
    as _i584;
import '../../features/progress/data/datasources/progress_local_datasource.dart'
    as _i247;
import '../../features/progress/data/repositories/progress_repository_impl.dart'
    as _i779;
import '../../features/progress/domain/repositories/progress_repository.dart'
    as _i785;
import '../../features/progress/domain/usecases/get_all_progress.dart' as _i325;
import '../../features/progress/domain/usecases/get_content_progress.dart'
    as _i564;
import '../../features/progress/domain/usecases/record_quiz_attempt.dart'
    as _i499;
import '../../features/progress/domain/usecases/unlock_content.dart' as _i837;
import '../../features/splash/presentation/cubit/splash_cubit.dart' as _i125;
import '../database/postgres_client.dart' as _i933;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i933.PostgresClient>(
      () => registerModule.postgresClient(),
    );
    gh.lazySingleton<_i518.ContentLocalDataSource>(
      () => _i518.ContentLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i247.ProgressLocalDataSource>(
      () => _i247.ProgressLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i785.ProgressRepository>(
      () => _i779.ProgressRepositoryImpl(gh<_i247.ProgressLocalDataSource>()),
    );
    gh.lazySingleton<_i321.ContentRemoteDataSource>(
      () => _i321.ContentRemoteDataSourceImpl(gh<_i933.PostgresClient>()),
    );
    gh.lazySingleton<_i325.GetAllProgress>(
      () => _i325.GetAllProgress(gh<_i785.ProgressRepository>()),
    );
    gh.lazySingleton<_i564.GetContentProgress>(
      () => _i564.GetContentProgress(gh<_i785.ProgressRepository>()),
    );
    gh.lazySingleton<_i499.RecordQuizAttempt>(
      () => _i499.RecordQuizAttempt(gh<_i785.ProgressRepository>()),
    );
    gh.lazySingleton<_i837.UnlockContent>(
      () => _i837.UnlockContent(gh<_i785.ProgressRepository>()),
    );
    gh.lazySingleton<_i1027.ContentRepository>(
      () => _i463.ContentRepositoryImpl(
        gh<_i321.ContentRemoteDataSource>(),
        gh<_i518.ContentLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i569.GetContentById>(
      () => _i569.GetContentById(gh<_i1027.ContentRepository>()),
    );
    gh.lazySingleton<_i458.GetContents>(
      () => _i458.GetContents(gh<_i1027.ContentRepository>()),
    );
    gh.lazySingleton<_i772.RefreshContents>(
      () => _i772.RefreshContents(gh<_i1027.ContentRepository>()),
    );
    gh.factory<_i1015.ContentDetailCubit>(
      () => _i1015.ContentDetailCubit(
        gh<_i569.GetContentById>(),
        gh<_i564.GetContentProgress>(),
        gh<_i837.UnlockContent>(),
      ),
    );
    gh.factory<_i584.ContentListCubit>(
      () => _i584.ContentListCubit(
        gh<_i458.GetContents>(),
        gh<_i325.GetAllProgress>(),
      ),
    );
    gh.factory<_i125.SplashCubit>(
      () => _i125.SplashCubit(gh<_i772.RefreshContents>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i913.RegisterModule {}
