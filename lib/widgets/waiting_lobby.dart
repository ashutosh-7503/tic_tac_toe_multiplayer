import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_multiplayer/provider/room_data_provider.dart';
import 'package:tic_tac_toe_multiplayer/responsive/responsive.dart';
import 'package:tic_tac_toe_multiplayer/widgets/custom_text_field.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController _roomIdController;
  @override
  void initState() {
    super.initState();
    _roomIdController = TextEditingController(
      text: Provider.of<RoomDataProvider>(
        context,
        listen: false,
      ).roomData['_id'],
    );
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Waiting for players to join....'),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _roomIdController,
              hintText: '',
              isReadOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
