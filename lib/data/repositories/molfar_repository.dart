import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/vehicle.dart';

part 'molfar_repository.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl:
          'https://duncishly-blowsiest-donte.ngrok-free.dev/api/v1',
      headers: {'ngrok-skip-browser-warning': 'true'},
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true),
  );

  return dio;
}

@riverpod
MolfarRepository molfarRepository(Ref ref) {
  return MolfarRepository(ref.watch(dioProvider));
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
