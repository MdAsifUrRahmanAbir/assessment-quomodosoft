import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assessment_quomodosoft/core/di/injection_container.dart' as di;
import 'package:assessment_quomodosoft/main.dart';

void main() {
  setUp(() async {
    // Reset dependency locator and set mock values for SharedPreferences
    await di.sl.reset();
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App smoke test - SignIn page renders correctly', (WidgetTester tester) async {
    await di.initDependencies();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const ServiceApp());

    // Verify that the sign-in page displays the welcome heading
    expect(find.text('Signin to Your Account'), findsOneWidget);
  });
}
