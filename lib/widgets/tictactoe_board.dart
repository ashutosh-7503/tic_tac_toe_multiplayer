import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_methods.dart';

class TictactoeBoard extends StatefulWidget {
  const TictactoeBoard({super.key});

  @override
  State<TictactoeBoard> createState() => _TictactoeBoardState();
}

class _TictactoeBoardState extends State<TictactoeBoard> {
  final SocketMethods _socketMethods = SocketMethods();
  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      roomId: roomDataProvider.roomData['_id'],
      index: index,
      displayElements: roomDataProvider.displayElements,
    );
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: size.height * 0.7),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] != _socketMethods.socketClient.id,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElements[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        shadows: [
                          Shadow(
                            blurRadius: 15,
                            color: roomDataProvider.displayElements[index] == 'O'
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
