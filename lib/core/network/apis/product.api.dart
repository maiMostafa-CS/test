
import '../base.api.dart';

enum ProductAPI implements API {
getProduct(path: "products", method: Method.get);

const ProductAPI({
required this.path,
required this.method,
});

@override
final String path;
@override
final Method method;
}
// "https://dummyjson.com/products"