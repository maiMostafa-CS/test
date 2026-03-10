import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/baseView/bloc_view.dart';
import 'package:flutter_application_1/core/bloc/base_event.dart';
import 'package:flutter_application_1/injection_container.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProductsBloc>()..add(FetchEvent()),
      child: BlocScaffold<ProductsBloc, List<Product>>(
        appBar: AppBar(title: const Text('Products')),
        onSuccess: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.title),
              subtitle: Text('Price: \$${product.price}'),
            );
          },
        ),
      ),
    );
  }
}
