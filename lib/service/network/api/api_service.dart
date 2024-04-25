import 'package:dio/dio.dart';
import 'package:news_multi_language/model/response/news_response.dart';
import 'package:news_multi_language/service/network/api/api_call.dart';
import 'package:news_multi_language/service/network/api/api_result.dart';
import 'package:news_multi_language/service/network/dio_client.dart';
import 'package:news_multi_language/service/network/dio_exception.dart';

class ApiService {
  final dioClient = DioClient(Dio());

  Future<ApiResult<NewsResponse>> getNews() async {
    String url = Endpoints.getNews.endpoint;
    try {
      final response = await dioClient.get(url);
      final result = NewsResponse.fromJson(response);
      print(result.toJson());
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }
}
