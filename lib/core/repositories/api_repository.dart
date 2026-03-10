import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_utilities.dart';

import '../network/base.api.dart';

/// A single generic repository that replaces the per-feature
/// DataSource + Repository pair.
///
/// Features no longer need their own datasource or repository
/// implementations — they simply call fetch() or submit() here.
class ApiRepository {
  final ApiHelper apiHelper;

  ApiRepository(this.apiHelper);



  Future<NetworkResponse<T>> fetch<T,V>({
    required API api,
    required T Function(Map<String, dynamic>) mapper,
    V? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? pathParam
  }) {
    return apiHelper.apiCall<T,V>(
      api: api,
      body: body,
      headers: headers,
      mapper: mapper,
      pathParam: pathParam,
      queryParameters: queryParameters
    );
  }
}
