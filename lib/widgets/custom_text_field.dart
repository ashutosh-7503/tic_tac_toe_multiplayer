import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';
import 'package:tic_tac_toe_multiplayer/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.blue, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          fillColor: Constants.bgColor,
          filled: true,
          suffixIcon: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: controller.text));
              showSnackBar(context, 'Copied to clipboard');
            },
            icon: Icon(Icons.copy),
          ),
        ),
      ),
    );
  }
}
