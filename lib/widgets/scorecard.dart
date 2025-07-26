import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';

class Scorecard extends StatelessWidget {
  const Scorecard({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                roomDataProvider.player1.nickname.length <= 5
                    ? roomDataProvider.player1.nickname
                    : '${roomDataProvider.player1.nickname.substring(0, 5)}..',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                roomDataProvider.player1.points.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                roomDataProvider.player2.nickname.length <= 5
                    ? roomDataProvider.player2.nickname
                    : '${roomDataProvider.player1.nickname.substring(0, 4)}..',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                roomDataProvider.player2.points.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
