import 'package:molfar/core/imports.dart';
import 'package:molfar/data/repositories/molfar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

class SearchState {
  final Vehicle? currentVehicle;
  final bool isLoading;
  final String? errorMessage;

  SearchState({
    this.currentVehicle,
    this.isLoading = false,
    this.errorMessage,
  });

  SearchState copyWith({
    Vehicle? currentVehicle,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      currentVehicle: currentVehicle,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, 
    );
  }
}

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  SearchState build() {
    return SearchState();
  }

  Future<void> search(String query, SearchMode mode) async {
    if (query.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, errorMessage: null, currentVehicle: null);

    final repository = await ref.read(molfarRepositoryProvider.future);
    final cleanQuery = query.replaceAll(' ', '');

    try {
      final result = await repository.searchVehicle(
        query: cleanQuery,
        isPlate: mode == SearchMode.plate,
      );

      state = state.copyWith(
        isLoading: false,
        currentVehicle: result, 
      );
      
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clear() {
    state = state.copyWith(currentVehicle: null, errorMessage: null);
  }
}