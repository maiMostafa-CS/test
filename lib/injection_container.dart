import 'package:flutter_application_1/ui/test/repo.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/network/api_helper.dart';
import 'features/products/data/datasources/repo.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/presentation/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// External
  sl.registerLazySingleton<Dio>(() => createDio());

  /// Core
  sl.registerLazySingleton<ApiHelper>(
        () => ApiHelper(sl()),
  );
  sl.registerLazySingleton<ProductsRepo>(
        () => ProductsRepo(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));

// Register Bloc
  sl.registerFactory(
        () => ProductsBloc(sl<GetProducts>()),
  );
}
