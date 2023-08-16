import '../../../api.dart' as api;

/// Class representing an ID for a single [api.Span].
/// See https://www.w3.org/TR/trace-context/#parent-id for full specification.
class SpanId {
  static const sizeBits = 16;
  static const sizeBytes = 8;

  late List<int> _id; // Added 'late' keyword

  SpanId(this._id);
  SpanId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateSpanId();
  }
  SpanId.fromString(String id) {
    _id = [];
    id = id.padLeft(api.SpanId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  SpanId.invalid() : _id = List<int>.filled(sizeBytes, 0);
  SpanId.root() : _id = [];

  /// Retrieve this SpanId as a list of byte values.
  List<int> get() => _id;

  /// Whether this ID represents a valid [api.Span].
  bool get isValid => _id.isEmpty || !_id.every((i) => i == 0);

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString() =>
      _id.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
