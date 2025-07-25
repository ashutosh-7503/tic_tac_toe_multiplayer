import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/resources/game_methods.dart';
import 'package:tic_tac_toe_multiplayer/screens/main_menu_screen.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.pop(context);
            },
            child: Text('Play Again'),
          ),
        ],
      );
    },
  );
}

void showGameWinnerDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainMenuScreen.routeName,
              (route) => false,
            );
          },
          child: Text('Ok'),
        ),
      ],
    ),
  );
}
