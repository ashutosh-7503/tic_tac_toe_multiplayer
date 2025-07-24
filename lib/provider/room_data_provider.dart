import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe_multiplayer/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  Player _player1 = Player(
    nickname: '',
    socketId: '',
    points: 0,
    playerType: 'X',
  );
  Player _player2 = Player(
    nickname: '',
    socketId: '',
    points: 0,
    playerType: 'O',
  );

  List<String> get displayElements => _displayElements;
  Map<String, dynamic> get roomData => _roomData;
  int get filledBoxes => _filledBoxes;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> data) {
    _player1 = Player.fromMap(data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> data) {
    _player2 = Player.fromMap(data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesToZero() {
    _filledBoxes = 0;
  }
}
