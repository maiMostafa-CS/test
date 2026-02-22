import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/products/domain/entities/product.dart';
import '   products_event.dart';
import '  products_state.dart';
import '../../domain/usecases/get_products.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProductsUseCase;

  ProductsBloc(this.getProductsUseCase) : super(ProductsInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    try {
      final products = await getProductsUseCase();
      emit(ProductsLoaded(products as List<Product>));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
