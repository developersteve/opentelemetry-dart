import '../../../api.dart' as api;

/// Class representing an ID for a single Trace.
/// See https://www.w3.org/TR/trace-context/#trace-id for full specification.
class TraceId {
  static const sizeBits = 32;
  static const sizeBytes = 16;

  late List<int> _id; // Added 'late' keyword

  TraceId(this._id);
  TraceId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateTraceId();
  }
  TraceId.fromString(String id) {
    _id = [];
    id = id.padLeft(TraceId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  TraceId.invalid() : _id = List<int>.filled(sizeBytes, 0);

  /// Retrieve this TraceId as a list of byte values.
  List<int> get() => _id;

  /// Whether this ID represents a valid Trace.
  bool get isValid => !_id.every((i) => i == 0);

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString() =>
      _id.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
