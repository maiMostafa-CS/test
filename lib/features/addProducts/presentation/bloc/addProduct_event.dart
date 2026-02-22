 // استبدل بمكان RequestProductModel

import '../../data/models/requestProduct_model.dart';

abstract class AddProductEvent  {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProductButtonPressed extends AddProductEvent {
  final RequestProductModel requestProductModel;

  const AddProductButtonPressed({required this.requestProductModel});

  @override
  List<Object?> get props => [requestProductModel];
}