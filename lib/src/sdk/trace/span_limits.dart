class SpanLimits {
  final int _DEFAULT_MAXNUM_ATTRIBUTES = 128;
  final int _DEFAULT_MAXNUM_EVENTS = 128;
  final int _DEFAULT_MAXNUM_LINKS = 128;
  final int _DEFAULT_MAXNUM_ATTRIBUTE_PER_EVENT = 128;
  final int _DEFAULT_MAXNUM_ATTRIBUTES_PER_LINK = 128;
  final int _DEFAULT_MAXNUM_ATTRIBUTES_LENGTH = -1;

  int _maxNumAttributes = 128;
  int _maxNumEvents = 128;
  int _maxNumLink = 128;
  int _maxNumAttributesPerEvent = 128;
  int _maxNumAttributesPerLink = 128;
  int _maxNumAttributeLength = -1;

  /// setters
  set maxNumAttributes(int maxNumberOfAttributes) {
    if (maxNumberOfAttributes < 0) {
      throw ArgumentError('maxNumAttributes must be greater or equal to zero');
    }
    _maxNumAttributes = maxNumberOfAttributes;
  }

  set maxNumEvents(int maxNumEvents) {
    if (maxNumEvents < 0) {
      throw ArgumentError('maxNumEvents must be greater or equal to zero');
    }
    _maxNumEvents = maxNumEvents;
  }

  set maxNumLink(int maxNumLink) {
    if (maxNumLink < 0) {
      throw ArgumentError('maxNumLink must be greater than or equal to zero');
    }
    _maxNumLink = maxNumLink;
  }

  set maxNumAttributesPerEvent(int maxNumAttributesPerEvent) {
    if (maxNumAttributesPerEvent < 0) {
      throw ArgumentError('maxNumAttributesPerEvent must be greater than or equal to zero');
    }
    _maxNumAttributesPerEvent = maxNumAttributesPerEvent;
  }

  set maxNumAttributesPerLink(int maxNumAttributesPerLink) {
    if (maxNumAttributesPerLink < 0) {
      throw ArgumentError('maxNumAttributesPerLink must be greater than or equal to zero');
    }
    _maxNumAttributesPerLink = maxNumAttributesPerLink;
  }

  set maxNumAttributeLength(int maxNumAttributeLength) {
    if (maxNumAttributeLength < 0) {
      throw ArgumentError('maxNumAttributeLength must be greater than or equal to zero');
    }
    _maxNumAttributeLength = maxNumAttributeLength;
  }

  /// getters
  int get maxNumAttributes => _maxNumAttributes;

  int get maxNumEvents => _maxNumEvents;

  int get maxNumLink => _maxNumLink;

  int get maxNumAttributesPerEvent => _maxNumAttributesPerEvent;

  int get maxNumAttributesPerLink => _maxNumAttributesPerLink;

  int get maxNumAttributeLength => _maxNumAttributeLength;

  /// constructor
  SpanLimits({
    int? maxNumAttributes,
    int? maxNumEvents,
    int? maxNumLink,
    int? maxNumAttributesPerEvent,
    int? maxNumAttributesPerLink,
    int? maxNumAttributeLength,
  }) {
    if (maxNumAttributes != null) {
      this.maxNumAttributes = maxNumAttributes;
    }
    if (maxNumEvents != null) {
      this.maxNumEvents = maxNumEvents;
    }
    if (maxNumLink != null) {
      this.maxNumLink = maxNumLink;
    }
    if (maxNumAttributesPerEvent != null) {
      this.maxNumAttributesPerEvent = maxNumAttributesPerEvent;
    }
    if (maxNumAttributesPerLink != null) {
      this.maxNumAttributesPerLink = maxNumAttributesPerLink;
    }
    if (maxNumAttributeLength != null) {
      this.maxNumAttributeLength = maxNumAttributeLength;
    }
  }
}
