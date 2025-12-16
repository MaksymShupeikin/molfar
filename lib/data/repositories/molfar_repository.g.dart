// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'molfar_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider
    extends $FunctionalProvider<AsyncValue<Dio>, Dio, FutureOr<Dio>>
    with $FutureModifier<Dio>, $FutureProvider<Dio> {
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
  $FutureProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Dio> create(Ref ref) {
    return dio(ref);
  }
}

String _$dioHash() => r'd48adb2aa4b3f2341642197f01e69aa8d4a315f8';

@ProviderFor(molfarRepository)
const molfarRepositoryProvider = MolfarRepositoryProvider._();

final class MolfarRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<MolfarRepository>,
          MolfarRepository,
          FutureOr<MolfarRepository>
        >
    with $FutureModifier<MolfarRepository>, $FutureProvider<MolfarRepository> {
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
  $FutureProviderElement<MolfarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MolfarRepository> create(Ref ref) {
    return molfarRepository(ref);
  }
}

String _$molfarRepositoryHash() => r'65564977bdd542b00c4af192b0033314ea864592';
