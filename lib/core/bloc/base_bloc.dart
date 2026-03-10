import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_event.dart';
import 'base_state.dart';
import '../usecases/base_usecase.dart';

/// A generic BLoC that handles both fetch (GET) and submit (POST/PUT/…) flows.
///
/// For **fetch** features provide [fetchUseCase] and dispatch [FetchEvent].
/// For **submit** features provide [submitUseCase] and dispatch [SubmitEvent].
///
/// Example — fetch:
/// ```dart
/// class ProductsBloc extends BaseBloc<List<Product>, Never> {
///   ProductsBloc(FetchUseCase<List<Product>> useCase)
///       : super(fetchUseCase: useCase);
/// }
/// ```
///
/// Example — submit:
/// ```dart
/// class AddProductBloc extends BaseBloc<ResponseProduct, RequestProduct> {
///   AddProductBloc(SubmitUseCase<RequestProduct, ResponseProduct> useCase)
///       : super(submitUseCase: useCase);
/// }
/// ```
class BaseBloc<Res, Req> extends Bloc<BaseEvent, BaseState<Res>> {
  final FetchUseCase<Res>? fetchUseCase;
  final SubmitUseCase<Req, Res>? submitUseCase;

  BaseBloc({this.fetchUseCase, this.submitUseCase})
      : super(InitialState<Res>()) {
    on<FetchEvent>(_onFetch);
    on<SubmitEvent<Req>>(_onSubmit);
  }

  Future<void> _onFetch(
      FetchEvent event, Emitter<BaseState<Res>> emit) async {
    if (fetchUseCase == null) return;
    emit(LoadingState<Res>());
    try {
      final data = await fetchUseCase!.call();
      emit(SuccessState<Res>(data));
    } catch (e) {
      emit(FailureState<Res>(e.toString()));
    }
  }

  Future<void> _onSubmit(
      SubmitEvent<Req> event, Emitter<BaseState<Res>> emit) async {
    if (submitUseCase == null) return;
    emit(LoadingState<Res>());
    try {
      final data = await submitUseCase!.call(event.request);
      emit(SuccessState<Res>(data));
    } catch (e) {
      emit(FailureState<Res>(e.toString()));
    }
  }
}
