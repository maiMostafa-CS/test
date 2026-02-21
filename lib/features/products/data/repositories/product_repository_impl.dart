import '../../domain/entities/ products_response.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductsResponse> getProducts() async {
    return await remoteDataSource.getProducts();
  }
}