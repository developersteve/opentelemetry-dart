import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A [api.Tracer] class which yields [api.NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  api.Span startSpan(String name,
      {api.Context? context,
      api.SpanKind? kind = api.SpanKind.internal,
      List<api.Attribute>? attributes = const [],
      List<api.SpanLink>? links = const [],
      Int64? startTime}) {
    final parentContext = context?.spanContext ?? sdk.SpanContext.invalid();

    return api.NonRecordingSpan(parentContext);
  }
}
