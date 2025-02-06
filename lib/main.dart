import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'helper/navigator_service.dart';
import 'module/news/cubit/news_cubit.dart';
import 'routes/routes.dart';
import 'utils/colors.dart';
import 'utils/log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addObserver(this);

    final newsCubit = BlocProvider<NewsCubit>(lazy: false, create: (_) => NewsCubit());

    return MultiBlocProvider(
      providers: [
        newsCubit
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
        title: 'News App',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: MyColors.primaryColor,
          fontFamily: "Asap",
          fontFamilyFallback: const ["Asap"],
        ),
        locale: const Locale('en', 'US'),
        localeResolutionCallback: (
          locale,
          supportedLocales,
        ) {
          return locale;
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('th', ''),
        ],
        navigatorKey: NavigationService.navigatorKey,
        routes: Routes.build,
        initialRoute: Routes.splash,
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) Log.d(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    Log.d(transition);
  }
}