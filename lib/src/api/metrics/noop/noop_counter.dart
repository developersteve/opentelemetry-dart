import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/experimental_api.dart';

/// A no-op instance of a [Counter]
class NoopCounter {
  final Map<String, dynamic>? attributes; // Nullable type

  NoopCounter({this.attributes = const <String, dynamic>{}}); // Default value provided
}

