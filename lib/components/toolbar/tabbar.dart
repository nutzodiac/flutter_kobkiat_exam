import 'package:flutter/material.dart';
import '../text/textlabel.dart';

class TabBarWidget extends StatelessWidget {
  final TabController controller; 

  const TabBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: const Color.fromARGB(255, 255, 228, 131),
        shape: BoxShape.circle,
      ),
      tabs: <Widget>[
        TabWidget(
          semanticslabel: 'Random',
          icon: Icons.access_alarm
        ),
        TabWidget(
          semanticslabel: 'Promotion',
          icon: Icons.access_alarm
        ),
        TabWidget(
          semanticslabel: 'Location',
          icon: Icons.access_alarm
        ),
        TabWidget(
          semanticslabel: 'Favourite',
          icon: Icons.access_alarm
        ),
        TabWidget(
          semanticslabel: 'Account',
          icon: Icons.access_alarm
        ),
      ],
    );
  }
}

class TabWidget extends StatelessWidget {
  final String semanticslabel;
  final String? text;
  final IconData? icon;
  final Color? color;

  const TabWidget({
    super.key,
    required this.semanticslabel,
    this.text,
    this.icon,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: semanticslabel,
      child: MergeSemantics(
        child: Tab(
          iconMargin: EdgeInsets.all(0.0),
          icon: icon != null ? Icon(icon, color: Colors.black) : null,
          child: text != null ? MyTextlabel.custom(
            text: text ?? "",
            fontWeight: FontWeight.w500,
            color: color ?? Colors.black,
          ) : SizedBox(),
        ),
      ),
    );
  }
}