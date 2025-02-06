import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../text/textlabel.dart';

mixin class MyDialog {

  showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: MyColors.primaryColor,
          ),
        );
      }
    );
  }

  hideProgressDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  showDialogDefaultMessage({
    required BuildContext context,
  }) => showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(color: MyColors.greyLightDivider, width: 1),
        ),
        child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: MyTextlabel.sizeS(
                  semanticslabel: 'DialogDefaultErrorMessage',
                  text: "An error occurred. Please try again.",
                  textAlign: TextAlign.center,
                  maxline: 1,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  child: MyTextlabel.sizeSS(
                    semanticslabel: 'DialogDefaultErrorButton',
                    text: "OK",
                    color: MyColors.blueTextDialog,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Future<void> showDialogMessage({
    required BuildContext context,
    Widget? icon,
    String? title,
    Color? titleColor,
    double? titleSize,
    String? message,
    double? messageSize,
    String? buttonLabel,
    bool? barrierDismissible,
    GestureTapCallback? callback,
    DialogMessageType type = DialogMessageType.INFORMATION,
    String? buttonLabel2,
    GestureTapCallback? callback2,
    final TextEditingController? controller,
  }) async => await showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(color: MyColors.greyLightDivider, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon ?? const SizedBox(),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.only(top: 10.0, bottom: message != null ? 5.0 : 10.0),
              child: MyTextlabel.custom(
                semanticslabel: 'DialogErrorTitle',
                text: title ?? "Error",
                fontWeight: FontWeight.bold,
                color: titleColor ?? MyColors.white,
                fontSize: titleSize ?? 18,
                textAlign: TextAlign.left,
              ),
            ),
            message != null
            ? Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 15.0),
              child: MyTextlabel.custom(
                semanticslabel: 'DialogErrorMessage',
                text: message,
                fontSize: messageSize ?? 16,
                maxline: 5,
              ),
            ) : const SizedBox(),
            const Divider(
              color: MyColors.greyLightDivider,
              height: 0,
              thickness: 1,
              endIndent: 0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      callback?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    child: MyTextlabel.custom(
                      semanticslabel: 'InformationButton',
                      text: buttonLabel ?? "OK",
                      fontWeight: FontWeight.bold,
                      color: MyColors.blueTextDialog,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class ItemMenu extends StatelessWidget {
  final String semanticLabel;
  final GestureTapCallback onTapMenu;
  final IconData icon;
  final String text;

  const ItemMenu({
    super.key,
    required this.semanticLabel,
    required this.onTapMenu,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMenu,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Semantics(
          identifier: semanticLabel,
          child: MergeSemantics(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(icon, color: Colors.black),
                ),
                MyTextlabel.sizeSS(semanticslabel: semanticLabel, text: text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum DialogMessageType {
  INFORMATION,
}