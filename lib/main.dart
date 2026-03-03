import 'package:flutter/material.dart';
import 'core/network/base_url.dart';
import 'features/addProducts/presentation/view/addProduct_screen.dart';
import 'injection_container.dart';

Future<void> main() async {
   ServiceUrl.configure(Flavor.DEV);
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddProductScreen(),
    );
  }
}
