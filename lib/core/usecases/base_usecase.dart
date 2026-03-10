/// Use case for GET-style operations that return data with no request body.
abstract class FetchUseCase<T> {
  Future<T> call();
}

/// Use case for submit-style operations (POST / PUT / PATCH / DELETE).
/// Returns the domain type [Res] directly — errors are surfaced as exceptions.
/// [Req] is the request entity, [Res] is the response entity.
abstract class SubmitUseCase<Req, Res> {
  Future<Res> call(Req request);
}
