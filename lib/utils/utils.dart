import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_methods.dart';
import 'package:tic_tac_toe_multiplayer/screens/main_menu_screen.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showGameDialog(
  BuildContext context,
  String text,
  String roomId,
  String socketId,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      bool isWaiting = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(text),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Next Round Will Start When Both The Players Are Ready..',
                ),
                const SizedBox(height: 20),
                if (isWaiting)
                  const CircularProgressIndicator()
                else
                  TextButton(
                    onPressed: () {
                      SocketMethods().playerReady(
                        roomId: roomId,
                        socketId: socketId,
                      );
                      setState(() {
                        isWaiting = true;
                      });
                    },
                    child: const Text('Ready'),
                  ),
                TextButton(
                  onPressed: () {
                    SocketMethods().leaveRoom(roomId: roomId);
                  },
                  child: Text('Leave Room'),
                ),
              ],
            ),
          );
        },
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
