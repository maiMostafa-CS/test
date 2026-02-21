import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products.dart';
import '../bloc/   products_event.dart';
import '../bloc/  products_state.dart';
import '../bloc/products_bloc.dart';

class ProductsView extends StatelessWidget {
  final GetProducts getProducts;

  const ProductsView({super.key, required this.getProducts});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(getProducts)..add(LoadProductsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              final products = state.products;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('Price: \$${product.price}'),
                  );
                },
              );
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
