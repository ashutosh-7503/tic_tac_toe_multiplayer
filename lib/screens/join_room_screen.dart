import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_methods.dart';
import 'package:tic_tac_toe_multiplayer/responsive/responsive.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_button.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_text.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    socketMethods.joinRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
    socketMethods.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CupertinoNavigationBar(backgroundColor: Constants.bgColor),
      body: Center(
        child: Responsive(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                  text: 'Join Room',
                  fontSize: 70,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter Your Nickname',
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextField(
                  controller: _idController,
                  hintText: 'Enter Your Room Id',
                ),
                SizedBox(height: size.height * 0.045),
                CustomButton(
                  onTap: () => socketMethods.joinRoom(
                    _nameController.text.trim(),
                    _idController.text.trim(),
                  ),
                  buttonText: 'Join',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
