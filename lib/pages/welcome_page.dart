import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/blocs/authentication/bloc.dart';
import 'package:learn_flutter/config/assets.dart';
import 'package:learn_flutter/config/pallete.dart';

class WelcomePage extends StatefulWidget {
  final Function _updatePageState;

  WelcomePage(this._updatePageState);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[buildHeaderSectionWidget(), buildGoogleButtonWidget()],
    );
  }

  Widget buildHeaderSectionWidget() {
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.only(top: 250),
          child: Image.asset(Assets.appLogo, height: 100)),
      Container(
          margin: EdgeInsets.only(top: 30),
          child: Text('Messio Messenger',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)))
    ]);
  }

  Widget buildGoogleButtonWidget() {
    return Container(
        margin: EdgeInsets.only(top: 100),
        child: FlatButton.icon(
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .dispatch(ClickedGoogleLogin()),
            color: Colors.transparent,
            icon: Image.asset(
              Assets.googleIcon,
              height: 25,
            ),
            label: Text(
              'Sign In with Google',
              style: TextStyle(
                  color: Palette.primaryTextColorLight,
                  fontWeight: FontWeight.w800),
            )));
  }
}
