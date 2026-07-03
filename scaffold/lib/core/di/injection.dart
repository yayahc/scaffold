import 'package:get_it/get_it.dart';

import '../../features/content/data/datasources/content_remote_datasource.dart';
import '../../features/content/data/repositories/content_repository_impl.dart';
import '../../features/content/domain/repositories/content_repository.dart';
import '../../features/content/domain/usecases/get_content_by_id.dart';
import '../../features/content/domain/usecases/get_contents.dart';
import '../../features/content/presentation/cubit/content_detail_cubit.dart';
import '../../features/content/presentation/cubit/content_list_cubit.dart';
import '../config/env.dart';
import '../database/postgres_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton(() => PostgresClient(Env.databaseUrl));

  sl.registerLazySingleton<ContentRemoteDataSource>(
    () => ContentRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ContentRepository>(
    () => ContentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetContents(sl()));
  sl.registerLazySingleton(() => GetContentById(sl()));
  sl.registerFactory(() => ContentListCubit(sl()));
  sl.registerFactory(() => ContentDetailCubit(sl()));
}
