import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class MyDropdownMenu extends StatefulWidget {
  final List<String> itemLists;
  const MyDropdownMenu({super.key, required this.itemLists});

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {

  @override
  Widget build(BuildContext context) {

    String dropdownValue = widget.itemLists.first;

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: DropdownMenu<String>(
        initialSelection: widget.itemLists.first,
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: MyColors.white,
          contentPadding: EdgeInsets.only(left: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: MyColors.primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: MyColors.primaryColor)
          ),
          constraints: BoxConstraints(
            maxHeight: 50
          )
        ),
        dropdownMenuEntries: widget.itemLists.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
