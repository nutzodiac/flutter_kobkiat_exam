import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/text/textlabel.dart';
import '../../../utils/colors.dart';
import '../../../utils/global.dart';
import '../../../utils/shared_pref.dart';
import '../../../components/dialog/toast_custom.dart';

class ArticleListview extends StatefulWidget {
  final bool isReadLaterPage;
  final int index;
  final dynamic news;
  final dynamic dateTimeArr;
  dynamic isReadLater;
  ArticleListview({super.key, this.isReadLaterPage = false, required this.index, required this.news, required this.dateTimeArr, this.isReadLater});

  @override
  State<ArticleListview> createState() => _ArticleListviewState();
}

class _ArticleListviewState extends State<ArticleListview> {

  SharedPref spf = SharedPref();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    fToast.showToast(
      child: ToastCustom(),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> saveArticleReadLater(index, article) async {
    String getCategory = Global.selectedCategory;
    if (!await spf.exists("articleReadLater")) {
      List articleLists = [{"category": getCategory, "index": index, "article": article}];
      spf.save("articleReadLater", articleLists);
      _showToast();
    } else {
      spf.read('articleReadLater').then((value) {
        if (value != null) {
          List articleReadLater = json.decode(value);
          bool exists = articleReadLater.any((article) => article['index'] == index && article['category'] == getCategory);
          if (exists) {
          } else {
            articleReadLater.add({"index": index, "article": article});
            spf.save("articleReadLater", articleReadLater);
            _showToast();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: MyColors.greenBoxBorder,
          width: 1.0,
        ),
      ),
      margin: EdgeInsets.all(10.0),
      color: MyColors.greenContent,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _launchUrl(widget.news.url),
                  child: Container(
                    width: 120,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(10.0),
                    child: widget.news.urlToImage != null ? Image.network(
                      '${widget.news.urlToImage}',
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return SizedBox(
                          width: 120,
                          child: Image.asset("assets/images/on_photo.png")
                        );
                      },
                    ) : SizedBox(
                      width: 120,
                      child: Image.asset("assets/images/on_photo.png")
                    )
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTextlabel.custom(
                      text: '${widget.news.title ?? ""}',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextlabel.custom(
                    text: '${widget.news.description ?? ""}',
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    maxline: 10,
                  ),
                  Padding(
                    padding: widget.isReadLaterPage ? EdgeInsets.only(top: 10.0) : EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Icon(Icons.calendar_month_outlined),
                                )
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: MyTextlabel.custom(
                                    text: '${widget.dateTimeArr[0]}',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: MyTextlabel.custom(
                                  text: '${widget.dateTimeArr[1]}',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.isReadLaterPage ? SizedBox()
                        : Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.isReadLater[widget.index] ? MyColors.black78 : MyColors.blueCircle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: widget.isReadLater[widget.index] ? null : () {
                                saveArticleReadLater(widget.index, widget.news);
                                setState(() {
                                  widget.isReadLater[widget.index] = true;
                                });
                              },                     
                              icon: Icon(Icons.bookmark_add_rounded, color: MyColors.white),
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}