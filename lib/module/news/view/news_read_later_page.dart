import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/text/textlabel.dart';
import '../../../helper/format_datetime.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/shared_pref.dart';
import '../components/article_listview.dart';
import '../model/response/news_response_model.dart';
import 'news_page.dart';

class NewsReadLaterPage extends StatefulWidget {
  const NewsReadLaterPage({super.key});

  @override
  State<NewsReadLaterPage> createState() => _NewsReadLaterPageState();
}

class _NewsReadLaterPageState extends State<NewsReadLaterPage> with TickerProviderStateMixin {

  SharedPref spf = SharedPref();
  List? newsArr;
  
  @override
  void initState() {
    super.initState();
    spf.read('articleReadLater').then((value) {
      if (value != null) {
        setState(() {
          newsArr = json.decode(value);
        });        
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyColors.primaryColor,
        backgroundColor: MyColors.primaryColor,
        title: MyTextlabel.custom(
          text: "Read Later",
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w600,
          fontSize: 26,
          color: MyColors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: newsArr != null ? ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: newsArr?.length ?? 0,
        itemBuilder: (context, index) {
          Article news = Article.fromJson(newsArr?[index]['article']);
          dynamic dateTimeArr = FormatDatetime.convertDateTime(news.publishedAt);
          return ArticleListview(isReadLaterPage: true, index: index, news: news, dateTimeArr: dateTimeArr);
        },
      ) : Center(
        child: MyTextlabel.custom(
          text: "No Article",
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: MyColors.black78,
        )
      ),
    );
  }
}