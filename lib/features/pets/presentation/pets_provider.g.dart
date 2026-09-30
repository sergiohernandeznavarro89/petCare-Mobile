// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PetsNotifier)
final petsProvider = PetsNotifierProvider._();

final class PetsNotifierProvider
    extends $AsyncNotifierProvider<PetsNotifier, List<PetDto>> {
  PetsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'petsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$petsNotifierHash();

  @$internal
  @override
  PetsNotifier create() => PetsNotifier();
}

String _$petsNotifierHash() => r'8841872cfdcb6e9fc4015ea7d3bc8cce064ab1e5';

abstract class _$PetsNotifier extends $AsyncNotifier<List<PetDto>> {
  FutureOr<List<PetDto>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<PetDto>>, List<PetDto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PetDto>>, List<PetDto>>,
              AsyncValue<List<PetDto>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
