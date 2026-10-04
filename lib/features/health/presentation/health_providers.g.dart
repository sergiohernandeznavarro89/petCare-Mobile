// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HealthAgenda)
final healthAgendaProvider = HealthAgendaProvider._();

final class HealthAgendaProvider
    extends
        $AsyncNotifierProvider<HealthAgenda, List<HealthEventOccurrenceDto>> {
  HealthAgendaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthAgendaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthAgendaHash();

  @$internal
  @override
  HealthAgenda create() => HealthAgenda();
}

String _$healthAgendaHash() => r'9ad502df66982d399e30dc654d5bf95debd3f951';

abstract class _$HealthAgenda
    extends $AsyncNotifier<List<HealthEventOccurrenceDto>> {
  FutureOr<List<HealthEventOccurrenceDto>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<HealthEventOccurrenceDto>>,
              List<HealthEventOccurrenceDto>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HealthEventOccurrenceDto>>,
                List<HealthEventOccurrenceDto>
              >,
              AsyncValue<List<HealthEventOccurrenceDto>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(HealthHistory)
final healthHistoryProvider = HealthHistoryFamily._();

final class HealthHistoryProvider
    extends $AsyncNotifierProvider<HealthHistory, List<HealthEventDto>> {
  HealthHistoryProvider._({
    required HealthHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'healthHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$healthHistoryHash();

  @override
  String toString() {
    return r'healthHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HealthHistory create() => HealthHistory();

  @override
  bool operator ==(Object other) {
    return other is HealthHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$healthHistoryHash() => r'dc0952caeb49858fc9e6300a5528c93f820f0af0';

final class HealthHistoryFamily extends $Family
    with
        $ClassFamilyOverride<
          HealthHistory,
          AsyncValue<List<HealthEventDto>>,
          List<HealthEventDto>,
          FutureOr<List<HealthEventDto>>,
          String
        > {
  HealthHistoryFamily._()
    : super(
        retry: null,
        name: r'healthHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HealthHistoryProvider call(String petId) =>
      HealthHistoryProvider._(argument: petId, from: this);

  @override
  String toString() => r'healthHistoryProvider';
}

abstract class _$HealthHistory extends $AsyncNotifier<List<HealthEventDto>> {
  late final _$args = ref.$arg as String;
  String get petId => _$args;

  FutureOr<List<HealthEventDto>> build(String petId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<HealthEventDto>>, List<HealthEventDto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HealthEventDto>>,
                List<HealthEventDto>
              >,
              AsyncValue<List<HealthEventDto>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
