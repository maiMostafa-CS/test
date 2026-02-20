import 'package:flutter/material.dart';
import '../../injection_container.dart';
import 'model.dart';
import 'repo.dart';

class AddProductScreen extends StatefulWidget {


  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  ProductsRepo  repo = sl<ProductsRepo>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  bool _isLoading = false;
  String? _result;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _result = null;
    });

    final request = RequestProduct(
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      brand: _brandController.text,
    );

    final response = await repo.getDelegates(
      delegatesRequestBody: request,
    );

    response.maybeWhen(
      ok: (product) {
        setState(() {
          _result =
          "Created Product:\nTitle: ${product?.title}\nBrand: ${product?.brand}\nPrice: ${product?.price}\n description: ${product?.description} ";
          _isLoading = false;
        });
      },
      onError: (error) {
        setState(() {
          _result = "Error: $error";
          _isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                    validator: (v) => v!.isEmpty ? "Enter title" : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: "Description"),
                    validator: (v) => v!.isEmpty ? "Enter description" : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price"),
                    validator: (v) =>
                    v!.isEmpty || double.tryParse(v) == null ? "Enter valid price" : null,
                  ),
                  TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: "Brand"),
                    validator: (v) => v!.isEmpty ? "Enter brand" : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Add Product"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_result != null)
              Text(
                _result!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
