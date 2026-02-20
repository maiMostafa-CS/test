import 'package:flutter_application_1/ui/repo.dart';
import 'package:flutter_application_1/ui/test/repo.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/network/api_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// External
  sl.registerLazySingleton<Dio>(() => createDio());

  /// Core
  sl.registerLazySingleton<ApiHelper>(
        () => ApiHelper(sl()),
  );
  sl.registerLazySingleton<Repo>(
        () => Repo(sl()),
  );
  sl.registerLazySingleton<ProductsRepo>(
        () => ProductsRepo(sl()),
  );
}
