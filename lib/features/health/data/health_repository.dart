import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../domain/health_event_dto.dart';
import '../domain/event_type_definition_dto.dart';
import '../domain/health_event_occurrence_dto.dart';

class HealthRepository {
  final Dio _dio;

  HealthRepository(this._dio);

  Future<List<EventTypeDefinitionDto>> getEventTypes() async {
    final response = await _dio.get('/EventTypes');
    return (response.data as List).map((json) => EventTypeDefinitionDto.fromJson(json)).toList();
  }

  Future<void> createEventType(EventTypeDefinitionDto eventType) async {
    await _dio.post('/EventTypes', data: eventType.toJson());
  }

  Future<void> updateEventType(String id, EventTypeDefinitionDto eventType) async {
    await _dio.put('/EventTypes/$id', data: eventType.toJson());
  }

  Future<void> deleteEventType(String id) async {
    await _dio.delete('/EventTypes/$id');
  }

  Future<void> createHealthEvent(String petId, HealthEventDto event) async {
    await _dio.post('/pets/$petId/health-events', data: event.toJson());
  }

  Future<void> updateHealthEvent(String petId, String id, HealthEventDto event) async {
    await _dio.put('/pets/$petId/health-events/$id', data: event.toJson());
  }

  Future<void> deleteHealthEvent(String petId, String id) async {
    await _dio.delete('/pets/$petId/health-events/$id');
  }

  Future<List<HealthEventOccurrenceDto>> getAgenda({String? petId, int skip = 0, int take = 20}) async {
    final String routeId = petId ?? '00000000-0000-0000-0000-000000000000';
    final res = await _dio.get('/pets/$routeId/health-events/agenda', queryParameters: {
      'skip': skip,
      'take': take,
    });
    final data = res.data as List;
    return data.map((json) => HealthEventOccurrenceDto.fromJson(json)).toList();
  }

  Future<List<HealthEventDto>> getHistory(String petId) async {
    final response = await _dio.get('/pets/$petId/health-events/history');
    final data = response.data as List;
    return data.map((json) => HealthEventDto.fromJson(json)).toList();
  }

  Future<void> completeOccurrence(String occurrenceId) async {
    final response = await _dio.patch('/HealthEventOccurrences/$occurrenceId/complete');
    if (response.statusCode != 200) throw Exception('Error completing occurrence');
  }

  Future<void> postponeOccurrence(String occurrenceId, DateTime newDate) async {
    final response = await _dio.patch('/HealthEventOccurrences/$occurrenceId/postpone', data: {
      'newDate': newDate.toUtc().toIso8601String(),
    });
    if (response.statusCode != 200) throw Exception('Error postponing occurrence');
  }

  Future<void> cancelOccurrence(String occurrenceId) async {
    final response = await _dio.patch('/HealthEventOccurrences/$occurrenceId/cancel');
    if (response.statusCode != 200) throw Exception('Error cancelling occurrence');
  }
}
final healthRepositoryProvider = Provider((ref) => HealthRepository(ref.watch(dioProvider)));