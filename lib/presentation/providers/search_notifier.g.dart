// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchNotifier)
const searchProvider = SearchNotifierProvider._();

final class SearchNotifierProvider
    extends $AsyncNotifierProvider<SearchNotifier, Vehicle?> {
  const SearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchNotifierHash();

  @$internal
  @override
  SearchNotifier create() => SearchNotifier();
}

String _$searchNotifierHash() => r'2875b2a66f7696dda8b47465020571baa7efeed1';

abstract class _$SearchNotifier extends $AsyncNotifier<Vehicle?> {
  FutureOr<Vehicle?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Vehicle?>, Vehicle?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Vehicle?>, Vehicle?>,
              AsyncValue<Vehicle?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
