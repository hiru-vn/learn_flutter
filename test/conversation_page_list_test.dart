import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/pages/conversation_page.dart';
import 'package:learn_flutter/pages/conversation_page_list.dart';

void main(){
  const MaterialApp app = MaterialApp(
    home: Scaffold(
        body: const ConversationPageList(),
    ),
  );
  testWidgets('ConversationPageList UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);
    expect(find.byType(ConversationPage),findsOneWidget);
    expect(find.byType(PageView),findsOneWidget);

  });
}