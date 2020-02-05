import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/blocs/authentication/bloc.dart';
import 'package:learn_flutter/config/assets.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/config/styles.dart';
import 'package:numberpicker/numberpicker.dart';

class SignUpPage extends StatefulWidget {
  final Function _updateAgeState;
  final int _age;

  SignUpPage(this._updateAgeState, this._age);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int age;
  Function updateAgeState;
  File profileImageFile;
  ImageProvider profileImage;
  AuthenticationBloc authenticationBloc;
  final TextEditingController usernameController = TextEditingController();

  //this variable keeps track of the keyboard, when its shown and when its hidden
  var isKeyboardOpen = false;
  
  //Fields related to animating the layout and pushing widgets up when the focus is on the username field
  AnimationController usernameFieldAnimationController;
  Animation profilePicHeightAnimation, usernameAnimation, ageAnimation;
  FocusNode usernameFocusNode = FocusNode();

  @override
  void initState() {
    age = widget._age;
    updateAgeState = widget._updateAgeState;

    WidgetsBinding.instance.addObserver(this);
    usernameFieldAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    profilePicHeightAnimation =
        Tween(begin: 100.0, end: 0.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    profilePicHeightAnimation =
        Tween(begin: 100.0, end: 0.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    usernameAnimation =
        Tween(begin: 50.0, end: 10.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    ageAnimation =
        Tween(begin: 80.0, end: 10.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });

    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        usernameFieldAnimationController.forward();
      } else {
        usernameFieldAnimationController.reverse();
      }
    });

    super.initState();
  }

  Future pickImage() async {
    profileImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    authenticationBloc.dispatch(PickedProfilePicture(profileImageFile));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    }, child: Container(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          profileImage = Image.asset(Assets.user).image;
          if (state is PreFillData) {
            age = state.user.age != null ? state.user.age : 18;
            profileImage = Image.network(state.user.photoUrl).image;
          } else if (state is ReceivedProfilePicture) {
            profileImageFile = state.file;
            profileImage = Image.file(profileImageFile).image;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: profilePicHeightAnimation.value),
              buildProfilePictureWidget(),
              SizedBox(
                height: ageAnimation.value,
              ),
              Text(
                'How old are you?',
                style: Styles.questionLight,
              ),
              buildAgePickerWidget(),
              SizedBox(
                height: usernameAnimation.value,
              ),
              Text(
                'Choose a username',
                style: Styles.questionLight,
              ),
              buildUsernameWidget()
            ],
          );
        },
      ),
    ));
  }

  buildProfilePictureWidget() {
    return GestureDetector(
      onTap: pickImage,
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
        backgroundImage: profileImage,
        radius: 60,
      ),
    );
  }

  buildAgePickerWidget() {
    return Row(
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
    );
  }

  buildUsernameWidget() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: 120,
        child: TextField(
          textAlign: TextAlign.center,
          style: Styles.subHeadingLight,
          focusNode: usernameFocusNode,
          controller: usernameController,
          decoration: InputDecoration(
            hintText: '@username',
            hintStyle: Styles.hintTextLight,
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.primaryColor, width: 0.1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.primaryColor, width: 0.1),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    usernameFieldAnimationController.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

   ///
  /// This routine is invoked when the window metrics have changed.
  /// Called when the application's dimensions change. When a phone is rotated, or keyboard pop up
  ///
  @override
  void didChangeMetrics() {
    final value = MediaQuery.of(context).viewInsets.bottom;
    if (value > 0) {
      if (isKeyboardOpen) {
        onKeyboardChanged(false);
      }
      isKeyboardOpen = false;
    } else {
      isKeyboardOpen = true;
      onKeyboardChanged(true);
    }
  }

  onKeyboardChanged(bool isVisible) {
    if (!isVisible) {
      FocusScope.of(context).requestFocus(FocusNode());
      usernameFieldAnimationController.reverse();
    }
  }
}
