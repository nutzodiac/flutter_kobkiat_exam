import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/dialog/dialog_custom.dart';
import '../../../components/text/textlabel.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/global.dart';
import '../../../utils/shared_pref.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import '../model/request/news_request_model.dart';
import '../model/response/news_response_model.dart';
import '../widgets/article_list_page.dart';
import '../widgets/article_one_page.dart';

class NewsPage extends StatelessWidget {

  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..loadNewsEvent(),
      child: NewsView(),
    );
  }
}

class NewsView extends StatefulWidget {

  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> with MyDialog, SingleTickerProviderStateMixin {

  SharedPref spf = SharedPref();
  bool isSingleArticle = true;
  final TextEditingController changeNewsController = TextEditingController();
  dynamic categoryLists = [
    {
      "icon": Icon(Icons.business_center_outlined, color: MyColors.white),
      "category": "Business"
    },
    {
      "icon": Icon(Icons.movie, color: MyColors.white),
      "category": "Entertainment"
    },
    {
      "icon": Icon(Icons.warning, color: MyColors.white),
      "category": "General"
    },
    {
      "icon": Icon(Icons.medical_services_outlined, color: MyColors.white),
      "category": "Health"
    },
    {
      "icon": Icon(Icons.science_outlined, color: MyColors.white),
      "category": "Science"
    },
    {
      "icon": Icon(Icons.sports_soccer, color: MyColors.white),
      "category": "Sports"
    },
    {
      "icon": Icon(Icons.settings, color: MyColors.white),
      "category": "Technology"
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: MyColors.primaryColor,
          backgroundColor: MyColors.primaryColor,
          title: MyTextlabel.custom(
            text: "News App",
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
            fontSize: 26,
            color: MyColors.white,
          ),
          actions: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: 10.0),
              child: IconButton(
                onPressed: () => setState(() {
                  isSingleArticle = !isSingleArticle;
                }),
                icon: Icon(isSingleArticle ? Icons.newspaper_outlined : Icons.list_alt_outlined, color: MyColors.white)
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.newsReadLater),
              icon: Icon(Icons.collections_bookmark_outlined, color: MyColors.white)
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 130,
              color: MyColors.greyBrightDisable,
              padding: const EdgeInsets.all(0.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: categoryLists.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.blueCircle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Global.selectedCategory = categoryLists[index]['category'].toLowerCase();
                                NewsRequestModel change = NewsRequestModel.fromJson({"category": categoryLists[index]['category']});
                                context.read<NewsCubit>().loadNewsEvent(change);
                              }, 
                              icon: categoryLists[index]['icon'],
                              iconSize: 30,
                            ),
                          )
                        ),
                      ),
                      MyTextlabel.custom(
                        text: categoryLists[index]['category'],
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: MyColors.black78,
                      )
                    ],
                  );
                }
              ),
            ),
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
                if (state is SuccessState) {
                  return Expanded(
                    child: isSingleArticle ? ArticleOnePage(newsData: state.data) : ArticleListPage(newsData: state.data),
                  );
                }
                if (state is ErrorState) {
                  return Expanded(
                    child: Center(
                      child: MyTextlabel.custom(
                        text: "No Article",
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: MyColors.black78,
                      )
                    ),
                  );
                }
                return Container();
              }
            ),
          ],
        )
      ),
    );
  }
}

class NewsArgument {
  dynamic newsData;
  int newsIndex;
  NewsArgument({required this.newsData, required this.newsIndex});
}