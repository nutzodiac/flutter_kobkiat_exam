import 'package:dio/dio.dart';

import '../../../dio/dio.dart';
import '../../../utils/global.dart';
import '../model/request/news_request_model.dart';

mixin class NewsRepository {
  Future<Response> loadTopHeadlinesNews([NewsRequestModel? newsRequestModel]) async {
    var category = newsRequestModel == null ? "" : "&category=${newsRequestModel.category}";
    Response responses = await MyDio.configureDio().get("https://newsapi.org/v2/top-headlines?country=us$category&pageSize=10&apiKey=c0a01831a63e4cf3a29d13916cc06c37");
    return responses;
  }
}
