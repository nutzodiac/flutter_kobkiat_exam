import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/shared_pref.dart';
import '../model/request/news_request_model.dart';
import '../model/response/news_response_model.dart';
import '../repository/news_repository.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> with NewsRepository {
  NewsCubit({NewsRepository? newsRepository}) : super(InitState());

  SharedPref spf = SharedPref();

  Future<void> loadNewsEvent([NewsRequestModel? event]) async {
    emit(LoadingState());
    try {
      if (await spf.exists("newsOnLocal")) {
        if (event != null) {
          spf.remove("newsOnLocal");
          final response = await loadTopHeadlinesNews(event);
          if (response.statusCode == 200) {
            NewsResponseModel data = NewsResponseModel.fromJson(response.data);
            if (data.status == "error") {
              emit(ErrorState(message: data.message.toString()));
            } else {
              if (data.totalResults != null && data.totalResults != 0) {
                spf.save("newsOnLocal", data);
                emit(SuccessState(data: data.articles));
              } else {
                emit(ErrorState(message: data.message.toString()));
              }
            }
          } else {
            emit(ErrorState(message: response.statusCode.toString()));
          }
        } else {
          spf.read('newsOnLocal').then((value) {
            if (value != null) {
              dynamic newsData = json.decode(value);
              NewsResponseModel newsOnLocal = NewsResponseModel.fromJson(newsData);
              emit(SuccessState(data: newsOnLocal.articles));
            }
          });
        }
      } else {
        final response = await loadTopHeadlinesNews();
        if (response.statusCode == 200) {
          NewsResponseModel data = NewsResponseModel.fromJson(response.data);
          if (data.status == "error") {
            emit(ErrorState(message: data.message.toString()));
          } else {
            if (data.totalResults != null && data.totalResults != 0) {
              spf.save("newsOnLocal", data);
              emit(SuccessState(data: data.articles));
            } else {
              emit(ErrorState(message: data.message.toString()));
            }
          }
        } else {
          emit(ErrorState(message: response.statusMessage.toString()));
        }
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}