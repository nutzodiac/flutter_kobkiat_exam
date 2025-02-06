import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../text/textlabel.dart';

class MyTextFormField extends StatelessWidget {
  final String semanticslabel;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? labelHeader;
  final TextStyle? headerStyle;
  final bool? isReqire;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final String? value;
  final GestureTapCallback? onTab;
  final bool? enabled;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? errorText;
  final TextAlign? textAlign;
  final bool? readOnly;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool setFocus;
  final Function? onTapTextField;
  final Function? onFieldSubmittedTextField;
  final BorderRadius? borderRadius;
  final String? counterText;
  final Color? fillColor;
  final FocusNode? setFocusNode;
  final FocusNode? nextFocusNode;
  const MyTextFormField(
      {super.key,
      required this.semanticslabel,
      this.hintText,
      this.hintTextStyle,
      this.labelHeader,
      this.headerStyle,
      this.isReqire,
      this.controller,
      this.textInputType,
      this.obscureText,
      this.value,
      this.onTab,
      this.enabled,
      this.prefixIcon,
      this.textInputAction,
      this.suffixIcon,
      this.onChanged,
      this.errorText,
      this.textAlign,
      this.readOnly,
      this.maxLength,
      this.inputFormatters,
      this.setFocus = false,
      this.onTapTextField,
      this.onFieldSubmittedTextField,
      this.borderRadius,
      this.counterText,
      this.fillColor,
      this.setFocusNode,
      this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelHeader != null
        ? Container(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: MyTextlabel.custom(
              semanticslabel: 'HeaderText$semanticslabel',
              text: labelHeader ?? "",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          )
        : const SizedBox(),
        Semantics(
          identifier: semanticslabel,
          label: semanticslabel,
          child: TextFormField(
            autofocus: setFocus,
            focusNode: setFocusNode,
            onFieldSubmitted: (String value) {
              if (onFieldSubmittedTextField != null) {
                onFieldSubmittedTextField!(value);
              }
            },
            readOnly: readOnly ?? false,
            onChanged: (String text) {
              if (onChanged != null) {
                onChanged!(text);
              }
            },
            onTap: () {
              if (onTapTextField != null) {
                onTapTextField!();
              }
            },
            maxLength: maxLength,
            textInputAction: textInputAction,
            enabled: enabled,
            obscureText: obscureText == null || obscureText == false ? false : true,
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            cursorColor: MyColors.primaryColor,
            initialValue: value,
            inputFormatters: inputFormatters ?? <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'(\u0020|[\u00a1-\u00a9]|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
            ],
            textAlign: textAlign ?? TextAlign.start,
            style: TextStyle(
              color: MyColors.black78,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontFamily: "Asap"
            ),
            decoration: InputDecoration(
              isDense: true,
              errorText: enabled == true || enabled == null ? errorText : null,
              suffixIcon: suffixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: MyColors.primaryColor),
                    child: suffixIcon ?? Container())
                : null,
              prefixIcon: prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: MyColors.primaryColor),
                    child: prefixIcon ?? Container())
                : null,
              hintText: hintText,
              hintStyle: hintTextStyle ?? TextStyle(color: MyColors.silverLight, fontSize: 17, fontWeight: FontWeight.w600, fontFamily: "Asap"),
              filled: true,
              fillColor: readOnly == true ? MyColors.greyBrightDisable : fillColor ?? Colors.white,
              contentPadding: const EdgeInsets.only(left: 20.0, bottom: 15.0, top: 10.0),
              border: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: MyColors.greyLight, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: MyColors.greyLight, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: MyColors.greyBrightDisable, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                borderSide: BorderSide(color: MyColors.primaryColor, width: 1.5),
              ),
              counterText: counterText ?? "",
            ),
          ),
        ),
      ],
    );
  }
}