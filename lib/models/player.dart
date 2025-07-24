// ignore_for_file: public_member_api_docs, sort_constructors_first
class Player {
  final String nickname;
  final String socketId;
  final int points;
  final String playerType;
  Player({
    required this.nickname,
    required this.socketId,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] as String,
      socketId: map['socketId'] as String,
      points: map['points'] as int,
      playerType: map['playerType'] as String,
    );
  }

  Player copyWith({
    String? nickname,
    String? socketId,
    int? points,
    String? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
