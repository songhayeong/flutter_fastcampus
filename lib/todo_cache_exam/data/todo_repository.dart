// 두개 이상의 데이터 소스 를 캡슐화 시켜서 해당 메서드들을 직접적인 연산 없이 사용하게 하는 디자인 패턴 중 하나

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:sliver_example/todo_cache_exam/api/api_service.dart';

import '../model/todo.dart';

class ToDoRepository {
  // cache와 api 호출 동시에 함
  final ApiService _apiService;
  final Box<ToDo> _todoBox;
  final _toDosController = StreamController<List<ToDo>>();

  ToDoRepository(this._apiService, this._todoBox) {
    _initialize();
  }

  Stream<List<ToDo>> get toDosStream => _toDosController.stream;

  void _initialize() async {
    // Emit initial data
    _emitCachedData();

    // Fetch new data from API and update stream
    await _fetchAndCachedToDos();
  }

  void _emitCachedData() {
    final cachedToDos = _todoBox.values.toList();
    _toDosController.add(cachedToDos);
  }

  Future<void> _fetchAndCachedToDos() async {
    try {
      final toDos = await _apiService.getToDos();

      for (var toDo in toDos) {
        _todoBox.put(toDo.id, toDo);
      }
      _emitCachedData();
    } catch (e) {
      print('Error fetching ToDos: $e');
    }
  }
  
  Future<void> createToDo(String text) async {
    try {
      final newToDo = await _apiService.createToDo(
        ToDo(id: '', text: text),
      );

      await _todoBox.put(newToDo.id, newToDo);
      _emitCachedData();
          
    } catch (e) {
      print("Error creating ToDo : $e");
    }
  }

  Future<void> updateToDo(String id) async {
    try {
      final updatedToDo = await _apiService.updateToDo(id);
      await _todoBox.put(id, updatedToDo);
      _emitCachedData(); // 해당 상태 방출
    } catch (e) {
      print('Error updating ToDo : $e');
    }
  }

  Future<void> refreshToDos() async {
    await _fetchAndCachedToDos();
}

  void dispose() {
    _toDosController.close();
  }
}