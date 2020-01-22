import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/conversation_bottom_sheet.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/chat_input.dart';
import '../widgets/chat_list.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage();
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: ChatAppBar(), // Custom app bar for chat screen
            body: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  ChatListWidget(), //Chat list
                  GestureDetector(
                      child: InputWidget(),
                      onPanUpdate: (details) {
                        // delta.dy > 0 would mean that the user swiped up and delta.dy < 0 would mean that the user swiped down.
                        if (details.delta.dy < 0) {
                          _scaffoldKey.currentState
                              .showBottomSheet<Null>((BuildContext context) {
                            return ConversationBottomSheet();
                          });
                        }
                      }) // The input widget
                ],
              ),
            ])));
  }
}
