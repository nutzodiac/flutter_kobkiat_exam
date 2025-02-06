
import 'package:flutter/material.dart';

class ToastCustom extends StatelessWidget {
  const ToastCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Text("Article saved to Read Later.")
    );
  }
}