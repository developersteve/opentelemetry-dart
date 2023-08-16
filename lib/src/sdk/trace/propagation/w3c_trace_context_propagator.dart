import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class W3CTraceContextPropagator implements api.TextMapPropagator {
  static const String _traceVersion = '00';
  static const String _traceParentHeaderKey = 'traceparent';
  static const String _traceStateHeaderKey = 'tracestate';
  static const String _traceVersionFieldKey = 'version';
  static const String _traceIdFieldKey = 'traceid';
  static const String _parentIdFieldKey = 'parentid';
  static const String _traceFlagsFieldKey = 'traceflags';

  // See https://www.w3.org/TR/trace-context/#traceparent-header-field-values
  // for trace parent header specification.
  static final RegExp traceParentHeaderRegEx =
      RegExp('^(?<$_traceVersionFieldKey>[0-9a-f]{2})-'
          '(?<$_traceIdFieldKey>[0-9a-f]{${api.TraceId.sizeBits}})-'
          '(?<$_parentIdFieldKey>[0-9a-f]{${api.SpanId.sizeBits}})-'
          '(?<$_traceFlagsFieldKey>[0-9a-f]{${2}})\$');

  @override
  api.Context extract(
      api.Context context, dynamic carrier, api.TextMapGetter getter) {
    final traceParentHeader = getter.get(carrier, _traceParentHeaderKey);
    if (traceParentHeader == null) {
      // Carrier did not contain a trace header.  Do nothing.
      return context;
    }
    if (!traceParentHeaderRegEx.hasMatch(traceParentHeader)) {
      // Encountered a malformed or unknown trace header.  Do nothing.
      return context;
    }

    final parentHeaderMatch =
        traceParentHeaderRegEx.firstMatch(traceParentHeader);
    final parentHeaderFields = Map<String, String?>.fromEntries(
      parentHeaderMatch?.groupNames
          ?.map((name) => MapEntry(name, parentHeaderMatch.namedGroup(name)))
          ?.where((entry) => entry.value != null) ?? [],
    );


    final traceId =
        api.TraceId.fromString(parentHeaderFields[_traceIdFieldKey]!) ??
            api.TraceId.invalid();
    final parentId =
        api.SpanId.fromString(parentHeaderFields[_parentIdFieldKey]!) ??
            api.SpanId.invalid();
    final traceFlags = int.parse(parentHeaderFields[_traceFlagsFieldKey]!,
            radix: 16) ??
        api.TraceFlags.none;

    final traceStateHeader = getter.get(carrier, _traceStateHeaderKey);
    final traceState = (traceStateHeader != null)
        ? sdk.TraceState.fromString(traceStateHeader)
        : sdk.TraceState.empty();

    return context.withSpan(api.NonRecordingSpan(
        sdk.SpanContext.remote(traceId, parentId, traceFlags, traceState)));
  }

  @override
  void inject(api.Context context, dynamic carrier, api.TextMapSetter setter) {
    final spanContext = context.spanContext;

    setter
      ..set(
          carrier,
          _traceParentHeaderKey,
          '$_traceVersion-${spanContext.traceId.toString()}-'
          '${spanContext.spanId.toString()}-'
          '${spanContext.traceFlags.toRadixString(16).padLeft(2, '0')}')
      ..set(carrier, _traceStateHeaderKey, spanContext.traceState.toString());
  }
}
