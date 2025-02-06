import 'package:flutter/material.dart';
import '../../../helper/format_datetime.dart';
import '../components/article_listview.dart';
import '../model/response/news_response_model.dart';

class ArticleListPage extends StatefulWidget {
  final dynamic newsData;

  const ArticleListPage({super.key, required this.newsData});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        primary: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(10.0),
        itemCount: widget.newsData.length ?? 0,
        itemBuilder: (context, index) {
          Article news = widget.newsData[index];
          dynamic dateTimeArr = FormatDatetime.convertDateTime(news.publishedAt);
          dynamic isReadLater = [];
          for (int i = 0; i < widget.newsData.length; i++) {
              isReadLater.add(false);
          }
          return ArticleListview(index: index, news: news, dateTimeArr: dateTimeArr, isReadLater: isReadLater);
        },
      ),
    );
  }
}