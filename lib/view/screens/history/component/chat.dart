import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/driverprofile.dart';
import 'package:uber_pro_kolkata/models/message_model.dart';
import 'package:uber_pro_kolkata/ui_compnents/message_bubble.dart';
import 'package:uber_pro_kolkata/ui_compnents/message_input_box.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/message_viewmodel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final DriverModel model;

  const ChatScreen({super.key, required this.model});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  ScrollController _scrollController = ScrollController();

  DriverModel get data => widget.model;

  WebSocketChannel? channel;

  void _addMessage(String text, bool isMe) {
    CustomerProfile customerProvider =
        Provider.of<CustomerProfile>(context, listen: false);
    Map msgData = {
      "message": text,
      "sender": customerProvider.currCustomerProfile?.id ?? -1,
      "receiver": data.id ?? 96,
    };
    channel!.sink.add(json.encode(msgData));
  }

  @override
  void initState() {
    super.initState();
    webSocketInit();
  }

  void webSocketInit() async {
    CustomerProfile customerProvider =
        Provider.of<CustomerProfile>(context, listen: false);
    int? id = customerProvider.currCustomerProfile?.id;

    MessageViewModel provider =
        Provider.of<MessageViewModel>(context, listen: false);
    await provider.getMessageRoom(context, id!, data.id!);

    debugPrint(provider.roomKey);
    getMessagesView();
    channel = await WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/chat/${provider.roomKey}'),
    );

    channel!.stream.listen((message) {
      Map data = jsonDecode(message);
      debugPrint("Received $message");
      if (id == data["sender"] || id == data["receiver"]) {
        setState(() {
          _messages.add(Message(
              text: data["message"],
              isMe: (id == data["sender"]),
              receiver: data["receiver"]));
        });
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildUserHeaderSection(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (ctx, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message.text,
                    isMe: message.isMe,
                  );
                },
              ),
            ),
            MessageInput(_addMessage),
          ],
        ),
      ),
    );
  }

  _buildUserHeaderSection() {
    return Container(
      width: AppSceenSize.getWidth(context) * 1,
      height: AppSceenSize.getHeight(context) * 0.20,
      color: const Color.fromRGBO(36, 46, 66, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.firstname ?? "No Name",
                    style: AppTextStyle.phoneverifytext),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void getMessagesView() async {
    CustomerProfile driverProvider =
        Provider.of<CustomerProfile>(context, listen: false);
    int? id = driverProvider.currCustomerProfile?.id ?? 96;

    MessageViewModel messageRoom =
        Provider.of<MessageViewModel>(context, listen: false);

    await messageRoom.getMessages(context, id, data.id!, messageRoom.roomKey);
    List<Message> list = messageRoom.messageList;
    setState(() {
      _messages = list;
    });
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
