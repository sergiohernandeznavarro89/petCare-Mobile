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
