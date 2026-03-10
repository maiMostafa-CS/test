import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/base_bloc.dart';
import '../bloc/base_state.dart';

// ─────────────────────────────────────────────────────────────
// BlocView<B, T>
//
// A generic BlocBuilder that maps every BaseState<T> to a Widget.
// Only [onSuccess] is required — the rest have sensible defaults.
//
// Usage:
//   BlocView<ProductsBloc, List<Product>>(
//     onSuccess: (data) => MyList(data),
//   )
// ─────────────────────────────────────────────────────────────
class BlocView<B extends BaseBloc<T, dynamic>, T> extends StatelessWidget {
  const BlocView({
    super.key,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onInitial,
  });

  /// Called when [SuccessState] is emitted — receives the typed data.
  final Widget Function(T data) onSuccess;

  /// Override the default loading indicator.
  final Widget Function()? onLoading;

  /// Override the default error widget — receives the error message.
  final Widget Function(String message)? onError;

  /// Override the default empty widget shown on [InitialState].
  final Widget Function()? onInitial;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BaseState<T>>(
      builder: (context, state) => switch (state) {
        LoadingState<T>() => onLoading?.call() ?? _defaultLoading(),
        SuccessState<T>(:final data) => onSuccess(data),
        FailureState<T>(:final message) =>
          onError?.call(message) ?? _defaultError(message),
        _ => onInitial?.call() ?? const SizedBox.shrink(),
      },
    );
  }

  Widget _defaultLoading() =>
      const Center(child: CircularProgressIndicator());

  Widget _defaultError(String message) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
// BlocScaffold<B, T>
//
// Wraps [BlocView] in a [Scaffold] and adds an optional
// [BlocListener] for side-effects (snackbars, navigation, etc.).
//
// Usage:
//   BlocScaffold<AddProductBloc, ResponseProductModel>(
//     appBar: AppBar(title: const Text('Add Product')),
//     onSuccess: (data) => MyForm(),
//     onListener: (context, state) {
//       if (state is SuccessState<ResponseProductModel>) {
//         ScaffoldMessenger.of(context).showSnackBar(...);
//       }
//     },
//   )
// ─────────────────────────────────────────────────────────────
class BlocScaffold<B extends BaseBloc<T, dynamic>, T> extends StatelessWidget {
  const BlocScaffold({
    super.key,
    required this.onSuccess,
    this.appBar,
    this.backgroundColor,
    this.onLoading,
    this.onError,
    this.onInitial,
    this.onListener,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final Widget Function(T data) onSuccess;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget Function()? onLoading;
  final Widget Function(String message)? onError;
  final Widget Function()? onInitial;

  /// Optional side-effect listener (snackbars, navigation, dialogs, etc.)
  final void Function(BuildContext context, BaseState<T> state)? onListener;

  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final view = BlocView<B, T>(
      onSuccess: onSuccess,
      onLoading: onLoading,
      onError: onError,
      onInitial: onInitial,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: onListener != null
          ? BlocListener<B, BaseState<T>>(
              listener: onListener!,
              child: view,
            )
          : view,
    );
  }
}
