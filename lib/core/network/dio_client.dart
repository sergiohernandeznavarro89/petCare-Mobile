import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

// Constante para el storage
const secureStorage = FlutterSecureStorage();

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // Usar la URL base de tu backend. Para Android Emulator apuntando a localhost, usa 10.0.2.2
      // Para iOS o web, localhost o tu IP de red local
      baseUrl: kIsWeb ? 'http://localhost:5085/api' : 'http://192.168.1.134:5085/api', 
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Interceptor para añadir el Token JWT si existe
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
}





