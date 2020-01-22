import 'package:flutter/material.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/config/styles.dart';
import 'package:learn_flutter/widgets/chat_row.dart';
import 'package:learn_flutter/widgets/navigation_pill.dart';

class ConversationBottomSheet extends StatefulWidget {
  @override
  _ConversationBottomSheetState createState() =>
      _ConversationBottomSheetState();

  const ConversationBottomSheet();
}

class _ConversationBottomSheetState extends State<ConversationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              NavigationPill(),
              Center(child: Text('Messages', style: Styles.textHeading)),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: 75, right: 20),
                    child: Divider(
                      color: Palette.accentColor,
                    )),
                itemBuilder: (context, index) {
                  return ChatRow();
                },
              )
            ]),
        onVerticalDragEnd: (details) {
          print('Dragged Down');
          // make sure that it’s greater than 50 so that it’s a drag and not just an accidental touch.
          if (details.primaryVelocity > 50) {
            Navigator.pop(context);
          }
        },
      ),
      
    ));
  }
}
