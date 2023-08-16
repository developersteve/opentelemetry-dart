import '../../../../../api.dart' as api;
import '../../../../../sdk.dart' as sdk;
import '../../../trace/tracer.dart';

class WebTracerProvider extends sdk.TracerProviderBase {
  final Map<String, api.Tracer> _tracers = {};
  final List<api.SpanProcessor> _processors;
  final sdk.Resource _resource;
  final sdk.Sampler _sampler;
  final sdk.TimeProvider _timeProvider;
  final api.IdGenerator _idGenerator;
  final sdk.SpanLimits _spanLimits;

  WebTracerProvider({
    List<api.SpanProcessor>? processors,
    sdk.Resource? resource,
    sdk.Sampler? sampler,
    sdk.TimeProvider? timeProvider,
    api.IdGenerator? idGenerator,
    sdk.SpanLimits? spanLimits,
  })  : _processors = processors ?? [],
        _resource = resource ?? sdk.Resource([]),
        _sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider(),
        _idGenerator = idGenerator ?? sdk.IdGenerator(),
        _spanLimits = spanLimits ?? sdk.SpanLimits(),
        super(
          processors: processors ?? [],
          resource: resource ?? sdk.Resource([]),
          sampler: sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
          idGenerator: idGenerator ?? sdk.IdGenerator(),
          spanLimits: spanLimits ?? sdk.SpanLimits(),
        );

  @override
  api.Tracer getTracer(String name, {String version = ''}) {
    return _tracers.putIfAbsent(
      '$name@$version',
      () => Tracer(
        _processors,
        _resource,
        _sampler,
        _timeProvider,
        _idGenerator,
        sdk.InstrumentationLibrary(name, version),
        spanLimits: _spanLimits,
      ),
    );
  }
}
