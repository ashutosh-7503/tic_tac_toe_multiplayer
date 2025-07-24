import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.blue, spreadRadius: 0, blurRadius: 8),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          minimumSize: Size(width, 50),
          backgroundColor: Constants.buttonColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
