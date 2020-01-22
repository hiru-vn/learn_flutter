import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/chat_input.dart';
import 'package:learn_flutter/widgets/conversation_bottom_sheet.dart';
import 'package:rubber/rubber.dart';
import 'conversation_page.dart';

class ConversationPageList extends StatefulWidget {
  const ConversationPageList();

  @override
  _ConversationPageListState createState() => _ConversationPageListState();
}

class _ConversationPageListState extends State<ConversationPageList> 
with SingleTickerProviderStateMixin {
  var controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = RubberAnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body: Column(
              children: <Widget>[
                Expanded(
                    child: PageView(
                  children: <Widget>[
                    ConversationPage(),
                    ConversationPage(),
                    ConversationPage()
                  ],
                )),
                Container(
                    child: GestureDetector(
                        child: InputWidget(),
                        onPanUpdate: (details) {
                          if (details.delta.dy < 0) {
                            _scaffoldKey.currentState
                                .showBottomSheet<Null>((BuildContext context) {
                              return ConversationBottomSheet();
                            });
                          }
                        }))
              ],
            )));
  }
}
