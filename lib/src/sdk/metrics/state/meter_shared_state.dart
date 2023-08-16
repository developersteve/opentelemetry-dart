import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'meter_provider_shared_state.dart';

class MeterSharedState {
  final MeterProviderSharedState _meterProviderSharedState;
  final InstrumentationScope _instrumentationScope;
  late sdk.Meter meter;

  MeterSharedState(this._meterProviderSharedState, this._instrumentationScope) {
    meter = sdk.Meter(this);
  }
}
