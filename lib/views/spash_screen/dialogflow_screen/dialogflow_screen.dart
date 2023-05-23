import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/colors.dart';

import 'Messages.dart';

class DialogflowScreen extends StatelessWidget {
  const DialogflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Bot extends StatefulWidget {
  const Bot({super.key});

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Pharmacybot"),
      ),
      body: Column(
        children: [
          Expanded(child: Messages(messages: messages)),
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: redColor,
            child: Row(children: [
              Expanded(
                  child: TextField(
                controller: _controller,
                style:const TextStyle(color: Colors.black),
              )),
              IconButton(
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                  icon:const Icon(Icons.send))
            ]),
          )
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({"message": message, "isUserMessage": isUserMessage});
  }
}
