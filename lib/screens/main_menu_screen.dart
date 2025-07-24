import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/responsive/responsive.dart';
import 'package:tic_tac_toe_multiplayer/screens/create_room_screen.dart';
import 'package:tic_tac_toe_multiplayer/screens/join_room_screen.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Responsive(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Image.asset(Constants.bannerImage),
                  ),
                ),
                SizedBox(height: 60),
                CustomButton(
                  onTap: () => createRoom(context),
                  buttonText: 'Create Room',
                ),
                SizedBox(height: 20),
                CustomButton(
                  onTap: () => joinRoom(context),
                  buttonText: 'Join Room',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
