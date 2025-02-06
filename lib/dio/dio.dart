import 'package:dio/dio.dart';

import '../components/dialog/dialog_custom.dart';
import '../helper/navigator_service.dart';
import '../utils/global.dart';
import '../utils/log.dart';

class MyDio {
  static final options = BaseOptions(
    baseUrl: Global.baseUrl,
    connectTimeout: const Duration(milliseconds: 100000),
    receiveTimeout: const Duration(milliseconds: 100000),
  );

  static Dio configureDio() {
    final Dio dio = Dio();
    dio.interceptors.add(MyInterceptors());
    return dio;
  }
}

class MyInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.d('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Log.d('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    try {
      MyDialog().showDialogMessage(
        context: NavigationService.navigatorKey.currentContext!,
        title: err.response?.statusMessage,
        message: err.response?.data['message'].toString()
      );
      super.onError(err, handler);
    } catch (e) {
      super.onError(err, handler);
    }
  }
}