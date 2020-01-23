import 'package:flutter/material.dart';
import 'package:learn_flutter/config/assets.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/config/styles.dart';
import 'package:numberpicker/numberpicker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int age = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100),
          Container(
              child: CircleAvatar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 15,
                ),
                Text(
                  'Set Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )
              ],
            ),
            backgroundImage: Image.asset(Assets.user).image,
            radius: 60,
          )),
          SizedBox(
            height: 50,
          ),
          Text(
            'How old are you?',
            style: Styles.questionLight,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NumberPicker.horizontal(
                  initialValue: age,
                  minValue: 15,
                  maxValue: 100,
                  highlightSelectedValue: true,
                  onChanged: (num value) {
                    setState(() {
                      age = value;
                    });
                  }),
              Text('Years', style: Styles.textLight)
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            child: Text(
              'Choose a username',
              style: Styles.questionLight,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              width: 120,
              child: TextField(
                textAlign: TextAlign.center,
                style: Styles.subHeadingLight,
                decoration: InputDecoration(
                  hintText: '@username',
                  hintStyle: Styles.hintTextLight,
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Palette.primaryColor, width: 0.1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Palette.primaryColor, width: 0.1),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
