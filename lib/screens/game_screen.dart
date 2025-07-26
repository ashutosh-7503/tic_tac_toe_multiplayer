import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_methods.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';
import 'package:tic_tac_toe_multiplayer/widgets/scorecard.dart';
import 'package:tic_tac_toe_multiplayer/widgets/tictactoe_board.dart';
import 'package:tic_tac_toe_multiplayer/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketMethods.updateRoomListener(context);
      _socketMethods.updatePlayerStateListener(context);
      _socketMethods.pointIncreaseListener(context);
      _socketMethods.endGameListener(context);
      _socketMethods.endGameDueToErrorListener(context);
      _socketMethods.playerLeftListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
    );
    return Scaffold(
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.all(0),
        backgroundColor: Constants.bgColor,
        trailing: TextButton(
          onPressed: () {
            _socketMethods.leaveRoom(roomId: roomDataProvider.roomData['_id']);
          },
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          child: Text(
            'Leave Room',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                children: [
                  const Scorecard(),
                  const TictactoeBoard(),
                  Text(
                    "${roomDataProvider.roomData['turn']['nickname']}'s turn",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
    );
  }
}
