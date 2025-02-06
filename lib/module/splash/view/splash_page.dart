import 'package:flutter/material.dart';
import '../../../components/text/textlabel.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 5), () {
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.news, (route) => false);
        }
      });
    });
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
      child: Container(
        color: MyColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/news_logo.png', width: 140),
              MyTextlabel.custom(
                text: "App News",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                color: MyColors.primaryColor,
                fontSize: 32,
              )
            ],
          )
        ),
      ),
    );
  }
}