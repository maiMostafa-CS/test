import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_product.dart';
import 'addProduct_event.dart';
import 'addProduct_state.dart';


class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProducts addProductsUseCase;

  AddProductBloc(this.addProductsUseCase) : super(AddProductInitial()) {
    on<AddProductButtonPressed>((event, emit) async {
      emit(AddProductLoading());
      try {
        final response = await addProductsUseCase.call(
          requestProductModel: event.requestProductModel,
        );

        if (response.isSuccess && response.data != null) {
          emit(AddProductSuccess(response.data));
        } else {
          emit(AddProductFailure(response.error ?? 'Unknown error'));
        }
      } catch (e) {
        emit(AddProductFailure(e.toString()));
      }
    });
  }
}