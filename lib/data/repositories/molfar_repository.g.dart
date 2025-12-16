// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'molfar_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'bd74229cecbb2922096a5c492ea2fb7aeffcd03f';

@ProviderFor(molfarRepository)
const molfarRepositoryProvider = MolfarRepositoryProvider._();

final class MolfarRepositoryProvider
    extends
        $FunctionalProvider<
          MolfarRepository,
          MolfarRepository,
          MolfarRepository
        >
    with $Provider<MolfarRepository> {
  const MolfarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'molfarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$molfarRepositoryHash();

  @$internal
  @override
  $ProviderElement<MolfarRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MolfarRepository create(Ref ref) {
    return molfarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MolfarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MolfarRepository>(value),
    );
  }
}

String _$molfarRepositoryHash() => r'9e065e2722547edb53c1ac4cd24f52101e882295';
