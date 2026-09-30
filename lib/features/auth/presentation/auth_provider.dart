import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import '../../../core/network/dio_client.dart';
import '../data/auth_repository.dart';
import '../domain/login_dto.dart';
import '../domain/register_dto.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  FutureOr<bool> build() async {
    final token = await secureStorage.read(key: 'jwt_token');
    
    if (token != null) {
      // Si el usuario no cerró sesión, le pedimos la huella por seguridad al abrir la app.
      try {
        final canCheckBiometrics = await _localAuth.canCheckBiometrics;
        final isDeviceSupported = await _localAuth.isDeviceSupported();

        if (canCheckBiometrics || isDeviceSupported) {
          final didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Inicia sesión con tu huella para acceder a PetCare',
            biometricOnly: true,
            persistAcrossBackgrounding: true,
          );
          
          if (didAuthenticate) {
            return true;
          } else {
            // Si el usuario cancela la huella, debe volver a loguearse
            return false;
          }
        }
        // Si no tiene biometría, lo dejamos pasar porque su sesión sigue abierta
        return true;
      } on PlatformException catch (_) {
        return false;
      }
    }
    return false;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.login(LoginDto(email: email, password: password));
      
      // Guardamos el token para mantener la sesión
      await secureStorage.write(key: 'jwt_token', value: response.token);
      
      // Guardamos credenciales seguras para la biometría futura (a petición del usuario)
      await secureStorage.write(key: 'saved_email', value: email);
      await secureStorage.write(key: 'saved_password', value: password);
      
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.register(RegisterDto(email: email, password: password));
      
      await secureStorage.write(key: 'jwt_token', value: response.token);
      await secureStorage.write(key: 'saved_email', value: email);
      await secureStorage.write(key: 'saved_password', value: password);
      
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> canUseBiometrics() async {
    // Verificamos si tenemos credenciales guardadas de una sesión anterior
    final savedEmail = await secureStorage.read(key: 'saved_email');
    final savedPassword = await secureStorage.read(key: 'saved_password');
    if (savedEmail == null || savedPassword == null) return false;

    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      return canCheck || isSupported;
    } catch (_) {
      return false;
    }
  }

  Future<void> loginWithBiometrics() async {
    state = const AsyncValue.loading();
    
    final email = await secureStorage.read(key: 'saved_email');
    final password = await secureStorage.read(key: 'saved_password');
    
    if (email == null || password == null) {
      state = AsyncValue.error(Exception('No hay credenciales previas guardadas.'), StackTrace.current);
      return;
    }

    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Inicia sesión con tu huella para acceder a PetCare',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      
      if (didAuthenticate) {
        // La huella es correcta. Hacemos login en el API silenciosamente con las credenciales guardadas.
        final repo = ref.read(authRepositoryProvider);
        final response = await repo.login(LoginDto(email: email, password: password));
        
        await secureStorage.write(key: 'jwt_token', value: response.token);
        state = const AsyncValue.data(true);
      } else {
        // Canceló la biometría
        state = const AsyncValue.data(false);
      }
    } catch (e, st) {
      state = AsyncValue.error(Exception('Error biométrico al iniciar sesión.'), st);
    }
  }

  Future<void> logout() async {
    // Al cerrar sesión borramos el token activo, 
    // pero MANTENEMOS el 'saved_email' y 'saved_password' para que la huella siga funcionando.
    await secureStorage.delete(key: 'jwt_token');
    state = const AsyncValue.data(false);
  }
}
