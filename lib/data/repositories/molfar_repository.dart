import 'package:dio/dio.dart';
import 'package:molfar/core/config_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/vehicle.dart';

part 'molfar_repository.g.dart';

@riverpod
Future<Dio> dio(Ref ref) async {
  final baseUrl = await ConfigLoader.getBaseUrl();

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {'ngrok-skip-browser-warning': 'true'},
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true),
  );

  return dio;
}

@riverpod
Future<MolfarRepository> molfarRepository(Ref ref) async {
  final dio = await ref.watch(dioProvider.future);
  return MolfarRepository(dio);
}

class MolfarRepository {
  final Dio _dio;

  MolfarRepository(this._dio);

  Future<Vehicle?> searchVehicle({
    required String query,
    required bool isPlate,
  }) async {
    try {
      final endpoint = isPlate ? '/search/plate' : '/search/vin';
      final paramKey = isPlate ? 'plate' : 'vin';

      final response = await _dio.get(
        endpoint,
        queryParameters: {paramKey: query},
      );

      final data = response.data;
      List<dynamic> list = [];

      if (data is List) {
        list = data;
      } else if (data is Map && data.containsKey('data')) {
        list = data['data'];
      }

      if (list.isEmpty) {
        return null;
      }

      return Vehicle.fromJson(list.first);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception('Server error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
}
