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
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
    );
    return Scaffold(
      appBar: CupertinoNavigationBar(backgroundColor: Constants.bgColor),
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
