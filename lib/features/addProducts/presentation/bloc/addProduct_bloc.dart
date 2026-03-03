import 'package:flutter_application_1/core/bloc/base_bloc.dart';
import 'package:flutter_application_1/features/addProducts/domain/entities/requestProduct.dart';
import 'package:flutter_application_1/features/addProducts/domain/entities/responseProduct.dart';
import '../../data/models/requestProduct_model.dart';
import '../../domain/usecases/add_product.dart';

class AddProductBloc
    extends BaseBloc<ResponseProduct, RequestProductModel> {
  AddProductBloc(AddProducts useCase) : super(submitUseCase: useCase);
}