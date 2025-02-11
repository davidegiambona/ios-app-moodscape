import 'package:flutter_test/flutter_test.dart';
import 'package:moodscape2/main.dart'; // Assicurati che il percorso sia corretto

void main() {
  testWidgets('Test del widget principale', (WidgetTester tester) async {
    // Costruisci l'app e avvia il test
    await tester.pumpWidget(MoodscapeApp());

    // Verifica che il titolo dell'app sia presente
    expect(find.text('Moodscape'), findsOneWidget);
  });
}
