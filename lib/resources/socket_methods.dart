import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';
import 'package:tic_tac_toe_multiplayer/resources/game_methods.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_client.dart';
import 'package:tic_tac_toe_multiplayer/screens/game_screen.dart';
import 'package:tic_tac_toe_multiplayer/screens/main_menu_screen.dart';
import 'package:tic_tac_toe_multiplayer/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickname});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void tapGrid({
    required String roomId,
    required int index,
    required List<String> displayElements,
  }) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  void leaveRoom({required String roomId}) {
    _socketClient.emit('leaveRoom', {'roomId': roomId});
  }

  void playerReady({required String roomId, required String socketId}) {
    _socketClient.emit('playerReady', {'roomId': roomId, 'socketId': socketId});
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      if (!context.mounted) return;
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(room);
      Navigator.pushNamedAndRemoveUntil(
        context,
        GameScreen.routeName,
        (route) => false,
      );
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      if (!context.mounted) return;
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(room);
      Navigator.pushNamedAndRemoveUntil(
        context,
        GameScreen.routeName,
        (route) => false,
      );
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      if (!context.mounted) return;
      showSnackBar(context, data);
    });
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      if (!context.mounted) return;
      final roomProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      roomProvider.updatePlayer1(playerData[0]);
      roomProvider.updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      if (!context.mounted) return;
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      if (!context.mounted) return;
      final roomProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      roomProvider.updateDisplayElements(data['index'], data['choice']);
      roomProvider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.off('pointIncrease');
    _socketClient.on('pointIncrease', (playerData) {
      if (!context.mounted) return;
      final roomProvider = Provider.of<RoomDataProvider>(
        context,
        listen: false,
      );
      if (playerData['socketId'] == roomProvider.player1.socketId) {
        roomProvider.updatePlayer1(playerData);
      } else {
        roomProvider.updatePlayer2(playerData);
      }
    });
  }

  void bothPlayersReadyListener(BuildContext context) {
    _socketClient.on('bothPlayersReady', (roomData) {
      Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).updateRoomData(roomData);
      Navigator.pop(context);
      GameMethods().clearBoard(context);
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      if (!context.mounted) return;
      showGameWinnerDialog(context, '${playerData['nickname']} won the game');
    });
  }

  void endGameDueToErrorListener(BuildContext context) {
    _socketClient.on('endGameDueToError', (data) {
      if (!context.mounted) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Game Over'),
          content: Text('${data['nickname']} has disconnected.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                MainMenuScreen.routeName,
                (route) => false,
              ),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  void playerLeftListener(BuildContext context) {
    _socketClient.on('playerLeft', (_) {
      if (!context.mounted) return;
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(MainMenuScreen.routeName, (route) => false);
    });
  }
}
