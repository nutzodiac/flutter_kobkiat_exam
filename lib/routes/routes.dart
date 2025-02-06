import 'package:flutter/material.dart';
import '../module/news/widgets/article_one_page.dart';
import '../module/news/view/news_page.dart';
import '../module/news/view/news_read_later_page.dart';
import '../module/splash/view/splash_page.dart';

class Routes {
  static const String login = "/login";
  static const String splash = "/splash";
  static const String news = "/news";
  static const String newsReadLater = "/news_read_later";
  static const String temp = "/temp";

  static Map<String, WidgetBuilder> build = {
    splash: (context) => const SplashPage(),
    news: (context) => const NewsPage(),
    newsReadLater: (context) => const NewsReadLaterPage(),
  };
}
