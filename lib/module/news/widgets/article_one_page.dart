import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/text/textlabel.dart';
import '../../../helper/format_datetime.dart';
import '../../../utils/colors.dart';
import '../../../utils/global.dart';
import '../../../utils/shared_pref.dart';
import '../../../components/dialog/toast_custom.dart';
import '../model/response/news_response_model.dart';

class ArticleOnePage extends StatefulWidget {
  final dynamic newsData;

  const ArticleOnePage({super.key, required this.newsData});

  @override
  State<ArticleOnePage> createState() => _ArticleOnePageState();
}

class _ArticleOnePageState extends State<ArticleOnePage> with TickerProviderStateMixin {

  late PageController _pageViewController;
  late TabController _tabController;
  int? _currentPageIndex;

  SharedPref spf = SharedPref();
  late FToast fToast;
  dynamic isReadLater = [];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
    _tabController = TabController(length: widget.newsData.length, vsync: this);
    fToast = FToast();
    fToast.init(context);
    for (int i = 0; i < widget.newsData.length; i++) {
      isReadLater.add("false");
    }
  }
  

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  _showToast() {
    fToast.showToast(
      child: ToastCustom(),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future<void> saveArticleReadLater(index, article, isReadLater) async {
    setState(() {
      isReadLater[index] = "true";
    });
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              itemCount: widget.newsData.length,
              itemBuilder: (BuildContext context, int itemIndex) {
                Article news = widget.newsData[itemIndex];
                dynamic dateTimeArr = FormatDatetime.convertDateTime(news.publishedAt);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: isReadLater[itemIndex] == "true" ? null : () {
                              saveArticleReadLater(itemIndex, widget.newsData[itemIndex], isReadLater);
                            },
                            icon: Icon(Icons.bookmark_add_rounded, color: isReadLater[itemIndex] == "true" ? MyColors.black78 : MyColors.blueCircle)
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            news.author != null ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.newspaper, color: MyColors.black78),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: MyTextlabel.custom(
                                    text: news.author ?? "",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                    fontSize: 16,
                                    maxline: 2,
                                  ),
                                ),
                              ],
                            ) : SizedBox(),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: RichText(
                                  textAlign: TextAlign.right,
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
                                            text: '${dateTimeArr != null ? dateTimeArr[0] : ''}',
                                            textAlign: TextAlign.right,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: MyTextlabel.custom(
                                          text: '${dateTimeArr != null ? dateTimeArr[1] : ''}',
                                          textAlign: TextAlign.right,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _launchUrl(news.url),
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: news.urlToImage != null ? Image.network(
                              '${news.urlToImage}',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: MyTextlabel.custom(
                            text: news.title ?? '',
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            maxline: 4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MyTextlabel.custom(
                            text: news.content ?? '',
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            maxline: 10
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex ?? 0,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb: false,
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: MyColors.greyBrightDisable,
            selectedColor: MyColors.blueCircle,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 9) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
