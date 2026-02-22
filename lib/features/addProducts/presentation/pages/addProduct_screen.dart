import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../data/models/requestProduct_model.dart';
import '../bloc/addProduct_bloc.dart';
import '../bloc/addProduct_event.dart';
import '../bloc/addProduct_state.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductBloc>(
      create: (_) => sl<AddProductBloc>(), // GetIt injects Bloc with repository
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product")),
        body: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            if (state is AddProductSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Product added: ${state.product.title}")),
              );
            } else if (state is AddProductFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.error}")),
              );
            }
          },
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description')),
                  TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                  TextField(controller: brandController, decoration: const InputDecoration(labelText: 'Brand')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final request = RequestProductModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        price: double.tryParse(priceController.text) ?? 0.0,
                        brand: brandController.text,
                      );

                      context.read<AddProductBloc>().add(
                        AddProductButtonPressed(requestProductModel: request),
                      );
                    },
                    child: const Text("Add Product"),
                  ),
                  if (state is AddProductSuccess) ...[
                    const Divider(),
                    const Text(
                      "Returned Data:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text("Title: ${state.product.title}"),
                    Text("Description: ${state.product.description}"),
                    Text("Price: ${state.product.price}"),
                    Text("Brand: ${state.product.brand}"),
                  ],

                  if (state is AddProductFailure)
                    Text(
                      "Error: ${state.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                ],

              ),
            );
          },
        ),
      ),
    );
  }
}