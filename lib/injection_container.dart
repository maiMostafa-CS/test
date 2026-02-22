import 'package:flutter_application_1/ui/test/repo.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/network/api_helper.dart';
import 'features/addProducts/data/datasources/repo.dart';
import 'features/addProducts/data/repositories/addProductsRepositories_impl.dart';
import 'features/addProducts/domain/repositories/addProductsRepositories.dart';
import 'features/addProducts/domain/usecases/add_product.dart';
import 'features/addProducts/presentation/bloc/addProduct_bloc.dart';
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
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton<GetProducts>(
        () => GetProducts(sl()),
  );






  sl.registerLazySingleton<AddProductsRepo>(
        () => AddProductsRepoImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AddProductsRepository>(
        () => addProductsRepositoriesImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton<AddProducts>(
        () => AddProducts(sl()),
  );

  // Bloc
  sl.registerFactory<AddProductBloc>(() => AddProductBloc(sl()));
}

