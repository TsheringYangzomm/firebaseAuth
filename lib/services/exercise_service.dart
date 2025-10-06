// lib/services/exercise_service.dart

import 'package:cloud_functions/cloud_functions.dart';
import '../models/exercise_model.dart';

class ExerciseService {
  // Instance to communicate with Firebase Functions
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<List<ExerciseModel>> searchExercises(String query) async {
    try {
      // Calls the deployed Node.js function 'searchExercises'
      final result = await _functions.httpsCallable('searchExercises').call({
        'query': query,
      });

      // The result.data is the JSON object returned by the JS function
      final List<dynamic> exerciseData = result.data['data'];
      
      // Convert the list of JSON maps into a list of Dart ExerciseModel objects
      return exerciseData
          .map((json) => ExerciseModel.fromJson(json as Map<String, dynamic>))
          .toList();
      
    } on FirebaseFunctionsException catch (e) {
      print('Firebase Function Error: ${e.code} - ${e.message}');
      // Return an empty list on error
      return []; 
    } catch (e) {
      print('General Exercise Search Error: $e');
      return [];
    }
  }
}