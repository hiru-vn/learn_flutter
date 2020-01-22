import 'package:flutter/material.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/pages/conversation_page_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
      ),
      home: ConversationPageList(),
    );
  }
}