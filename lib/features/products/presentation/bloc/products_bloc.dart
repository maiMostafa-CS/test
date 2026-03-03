import 'package:flutter_application_1/core/bloc/base_bloc.dart';
import 'package:flutter_application_1/features/products/domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

class ProductsBloc extends BaseBloc<List<Product>, Never> {
  ProductsBloc(GetProducts useCase) : super(fetchUseCase: useCase);
}
