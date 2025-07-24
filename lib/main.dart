import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';
import 'package:tic_tac_toe_multiplayer/screens/create_room_screen.dart';
import 'package:tic_tac_toe_multiplayer/screens/game_screen.dart';
import 'package:tic_tac_toe_multiplayer/screens/join_room_screen.dart';
import 'package:tic_tac_toe_multiplayer/screens/main_menu_screen.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Constants.bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context)=> const MainMenuScreen(),
          CreateRoomScreen.routeName: (context)=>const  CreateRoomScreen(),
          JoinRoomScreen.routeName: (context)=> const JoinRoomScreen(),
          GameScreen.routeName: (context)=> const GameScreen(),
        },
        home: const MainMenuScreen(),
      ),
    );
  }
}
