import 'dart:async';
import 'package:molfar/core/imports.dart';
import 'package:molfar/data/repositories/molfar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  FutureOr<Vehicle?> build() {
    return null;
  }

  Future<void> search(String query, SearchMode mode) async {
    if (query.trim().isEmpty) return;

    state = const AsyncValue.loading();

    final repository = ref.read(molfarRepositoryProvider);

    final cleanQuery = query.replaceAll(' ', '');

    state = await AsyncValue.guard(() async {
      return await repository.searchVehicle(
        query: cleanQuery,
        isPlate: mode == SearchMode.plate,
      );
    });
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}
