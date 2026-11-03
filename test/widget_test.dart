import 'package:flutter_test/flutter_test.dart';

import 'package:calorie_tracker/main.dart';

void main() {
  testWidgets('Calorie tracker app loads with main text', (tester) async {
    await tester.pumpWidget(const CalorieTrackerApp());

    expect(find.text('Calorie Tracker'), findsOneWidget);
    expect(find.text('Your daily nutrition'), findsOneWidget);
    expect(find.text('Add Food'), findsOneWidget);
    expect(find.text('Today’s food'), findsOneWidget);
  });
}
