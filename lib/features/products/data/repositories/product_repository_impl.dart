import '../../../../core/network/api_helper.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<NetworkResponse> getProducts() async {
    return await remoteDataSource.getProducts();
  }
}