import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/blocs/authentication/bloc.dart';
import 'package:learn_flutter/config/assets.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/config/transitions.dart';
import 'package:learn_flutter/pages/conversation_page_list.dart';
import 'package:learn_flutter/pages/signup_page.dart';
import 'package:learn_flutter/pages/welcome_page.dart';
import 'package:learn_flutter/widgets/circle_indicator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  AuthenticationBloc authenticationBloc;
  int currentPage = 0;

  PageController pageController = PageController();
  // this is the controller of the page. This is used to navigate back and forth between the pages

  //Fields related to animation of the gradient
  Alignment begin = Alignment.center;
  Alignment end = Alignment.bottomRight;

  //Fields related to animating the layout and pushing widgets up when the focus is on the username field
  AnimationController usernameFieldAnimationController;
  Animation profilePicHeightAnimation, usernameAnimation, ageAnimation;
  FocusNode usernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void initApp() async {
    pageController.addListener(() {
      setState(() {
        begin = Alignment(pageController.page, pageController.page);
        end = Alignment(1 - pageController.page, 1 - pageController.page);
      });
    });

    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.state.listen((state) {
      if (state is Authenticated) {
        updatePageState(1);
      }
    });
  }

  navigateToHome() {
    Navigator.push(
      context,
      SlideLeftRoute(page: ConversationPageList()),
    );
  }

  updatePageState(index) {
    if (index == 1)
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);

    setState(() {
      currentPage = index;
    });
  }

  updateAgeState(value) {
    setState(() {
      age = value;
    });
  }

  Future<bool> onWillPop() {
    if (currentPage == 1) {
      //go to first page if currently on second page
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop, //user to override the back button press
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          //  avoids the bottom overflow warning when keyboard is shown
          body: SafeArea(
            child: Stack(children: <Widget>[
              buildHome(),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthInProgress ||
                      state is ProfileUpdateInProgress) {
                    return buildCircularProgressBarWidget();
                  }
                  return SizedBox();
                },
              )
            ]),
          ),
        ));
  }

  Widget buildHome() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: begin, end: end, colors: [
          Palette.gradientStartColor,
          Palette.gradientEndColor
        ])),
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int page) => updatePageState(page),
                      children: <Widget>[
                        WelcomePage(updatePageState),
                        SignUpPage(updateAgeState, age),
                      ])),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < 2; i++)
                      CircleIndicator(i == currentPage),
                  ],
                ),
              ),
              AnimatedOpacity(
                  opacity: currentPage == 1 ? 1.0 : 0.0, //shows only on page 1
                  duration: Duration(milliseconds: 500),
                  child: Container(
                      margin: EdgeInsets.only(right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () => navigateToHome(),
                            elevation: 0,
                            backgroundColor: Palette.primaryColor,
                            child: Icon(
                              Icons.done,
                              color: Palette.accentColor,
                            ),
                          )
                        ],
                      )))
            ]));
  }

  buildCircularProgressBarWidget() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: begin, end: end, colors: [
          Palette.gradientStartColor,
          Palette.gradientEndColor
        ])),
        child: Container(
            child: Center(
          child: Column(children: <Widget>[
            buildHeaderSectionWidget(),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Palette.primaryColor)),
            )
          ]),
        )));
  }

  buildHeaderSectionWidget() {
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
}
