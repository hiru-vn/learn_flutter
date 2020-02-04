import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/config/pallete.dart';
import 'package:learn_flutter/pages/conversation_page_list.dart';
import 'package:learn_flutter/pages/register_page.dart';

import 'package:learn_flutter/repositories/authentication_repository.dart';
import 'package:learn_flutter/repositories/storage_repository.dart';
import 'repositories/userData_repository.dart';

import 'blocs/authentication/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();

  runApp(BlocProvider(
    builder: (context) => AuthenticationBloc(
        authenticationRepository: authRepository,
        userDataRepository: userDataRepository,
        storageRepository: storageRepository)
      ..dispatch(AppLaunched()), //trigger launch event
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            return ConversationPageList();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}

// happy new year 2020
