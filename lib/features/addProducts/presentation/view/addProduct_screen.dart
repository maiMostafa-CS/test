import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/bloc/base_event.dart';
import 'package:flutter_application_1/injection_container.dart';
import '../../../../core/baseView/bloc_view.dart';
import '../../../../core/bloc/base_state.dart';
import '../../data/models/requestProduct_model.dart';
import '../../domain/entities/responseProduct.dart';
import '../bloc/addProduct_bloc.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AddProductBloc>(),
      child: Builder(builder: (context) {
          return BlocScaffold<AddProductBloc, ResponseProduct>(
            appBar: AppBar(title: const Text("Add Product")),

            onSuccess: (data) => _buildForm(context, data),
            // onInitial: () => _buildForm(context, null),

            onListener: (context, state) {
              if (state is SuccessState<ResponseProduct>) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Product added: ${state.data.title}")),
                );
              }

              if (state is FailureState<ResponseProduct>) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.message}")),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, ResponseProduct? data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final request = RequestProductModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  price:
                  double.tryParse(priceController.text) ?? 0.0,
                  brand: brandController.text,
                );

                context
                    .read<AddProductBloc>()
                    .add(SubmitEvent(request));
              },
              child: const Text("Add Product"),
            ),

            /// 🔥 Show returned data only when success
            if (data != null) ...[
              const Divider(),
              const Text(
                "Returned Data:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Title: ${data.title}"),
              Text("Description: ${data.description}"),
              Text("Price: ${data.price}"),
              Text("Brand: ${data.brand}"),
            ],
          ],
        ),
      ),
    );
  }
}