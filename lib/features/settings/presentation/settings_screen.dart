import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_provider.dart';
import '../../auth/presentation/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Gestión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Administración de Mascotas'),
            subtitle: const Text('Añade, edita o elimina tus mascotas'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.go('/settings/pets');
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services),
            title: const Text('Tipos de Eventos'),
            subtitle: const Text('Gestiona los tipos de eventos personalizados'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.go('/settings/event-types');
            },
          ),
          const Divider(height: 32),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              'Apariencia y Tema',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('Sistema'),
                  icon: Icon(Icons.brightness_auto),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('Claro'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('Oscuro'),
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            onTap: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
