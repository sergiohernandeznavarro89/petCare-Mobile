import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../domain/auth_response_dto.dart';
import '../domain/login_dto.dart';
import '../domain/register_dto.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponseDto> login(LoginDto dto) async {
    try {
      final response = await _dio.post('/Auth/login', data: dto.toJson());
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<AuthResponseDto> register(RegisterDto dto) async {
    try {
      final response = await _dio.post('/Auth/register', data: dto.toJson());
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Error en el registro: $e');
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(dioProvider));
}

