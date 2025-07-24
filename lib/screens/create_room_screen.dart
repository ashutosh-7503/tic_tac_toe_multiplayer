import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_multiplayer/resources/socket_methods.dart';
import 'package:tic_tac_toe_multiplayer/responsive/responsive.dart';
import 'package:tic_tac_toe_multiplayer/utils/constants.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_button.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_text.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';

  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                  text: 'Create Room',
                  fontSize: 70,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter Your Nickname',
                ),
                SizedBox(height: size.height * 0.045),
                CustomButton(
                  onTap: () => _socketMethods.createRoom(_nameController.text),
                  buttonText: 'Create',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
