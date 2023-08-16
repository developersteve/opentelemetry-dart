
enum StatusCode {
  /// The default status.
  unset,

  /// The operation contains an error.
  error,

  /// The operation has been validated by an Application developers or
  /// Operator to have completed successfully.
  ok,
}

/// A representation of the status of a Span.
class SpanStatus {
  StatusCode code = StatusCode.unset;
  late String description;

  SpanStatus({this.description = ""});
}
