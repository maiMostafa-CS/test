import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/network/api_helper.dart';
import 'core/repositories/api_repository.dart';

import 'features/addProducts/data/datasources/repo.dart';
import 'features/products/data/datasources/repo.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/presentation/bloc/products_bloc.dart';

import 'features/addProducts/domain/repositories/addProductsRepositories.dart';
import 'features/addProducts/domain/usecases/add_product.dart';
import 'features/addProducts/data/repositories/addProducts_repository_impl.dart';
import 'features/addProducts/presentation/bloc/addProduct_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // ─── External ────────────────────────────────────────────────
  locator.registerLazySingleton<Dio>(() => createDio());

  // ─── Core ────────────────────────────────────────────────────
  locator.registerLazySingleton<ApiHelper>(() => ApiHelper(locator()));
  locator.registerLazySingleton<ApiRepository>(() => ApiRepository(locator()));

  // ─── Products (fetch) ────────────────────────────────────────
  locator.registerLazySingleton<GetProducts>(() => GetProducts(locator()));
  locator.registerFactory<ProductsBloc>(() => ProductsBloc(locator()));
  locator.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl( locator()),
  );
  // ─── Add Product (submit) ────────────────────────────────────
// 1. Data source
  locator.registerLazySingleton<AddProductRemoteDataSource>(
        () => AddProductRemoteDataSourceImpl(locator()), // make sure constructor expects Dio or ApiHelper
  );

// 2. Repository
  locator.registerLazySingleton<AddProductsRepository>(
        () => AddProductsRepositoryImpl(locator()), // resolves AddProductRemoteDataSource
  );

// 3. Use case
  locator.registerLazySingleton<AddProducts>(
        () => AddProducts(locator()), // resolves AddProductsRepository
  );

// 4. Bloc
  locator.registerFactory<AddProductBloc>(
        () => AddProductBloc(locator()), // resolves AddProducts use case
  );
}
