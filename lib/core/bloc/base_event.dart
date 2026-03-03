sealed class BaseEvent {}

/// Triggers a fetch (GET) operation — no payload needed.
class FetchEvent extends BaseEvent {}

/// Triggers a submit (POST / PUT / PATCH / DELETE) operation.
/// [request] carries the request body/parameters.
class SubmitEvent<T> extends BaseEvent {
  final T request;
  SubmitEvent(this.request);
}
