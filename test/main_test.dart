import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/pages/conversation_page_list.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Main UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // the test waits for the widget to load and only once its loaded, moves on and executes the next line.
    await tester.pumpWidget(MyApp());
    // expect method is part of the flutter_test package. It takes two arguments, a Finder and a Matcher.
    // The Finder defines what exactly we’re trying to find in the UI. It can be find.byType, find.text and many more.
    // The Matcher is the second argument in the expect function and it defines the number of instances we’re expecting to find. It can be findsOneWidget, findsNWidget, findsWidget and findsNothing.
    expect(find.byType(ConversationPageList),findsOneWidget);
  });
}