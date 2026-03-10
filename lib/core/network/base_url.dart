

enum Flavor {DEV,PROD}
class ServiceUrl {
  static final ServiceUrl _singleton = ServiceUrl._internal();
  static Flavor? _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory ServiceUrl() {
    return _singleton;
  }

  ServiceUrl._internal();

  String get baseUrl {
    switch (_flavor) {
      case Flavor.PROD:
      return "https://dummyjson.com/";//production";
      case Flavor.DEV:
        return "https://dummyjson.com/";//dev
      default:
        return "https://dummyjson.com/";
    }

  }

}