import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../model/todo.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://localhos:3000')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/todo")
  Future<List<ToDo>> getToDos();

  @POST("/todo")
  Future<ToDo> createToDo(@Body() ToDo toDo);

  @PATCH("/todo/{id}")
  Future<ToDo> updateToDo(@Path('id') String id);
}