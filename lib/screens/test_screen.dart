/*
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://initial.emasbd.com/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST("api/college/employeepanel/class_materials/1")
  @MultiPart()
  Future<String> uploadFile(
      @Part() File file,
      @Part(name: "name") String name,
      @Part(name: "description") String description,
      {@SendProgress() ProgressCallback? onSendProgress});
}
*/
