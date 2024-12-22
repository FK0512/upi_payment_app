import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upi_payment_app/main.dart'; // Update with your app's entry point

void main() {
  testWidgets('UPI Payment App UI Test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(UPIPaymentApp());

    // Verify that the app displays the required UI elements.
    expect(find.text('Enter Receiver UPI ID'), findsOneWidget);
    expect(find.text('Enter Amount (INR)'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);

    // Enter text into the UPI ID field.
    await tester.enterText(find.byType(TextField).first, 'test@upi');
    expect(find.text('test@upi'), findsOneWidget);

    // Enter text into the amount field.
    await tester.enterText(find.byType(TextField).last, '100');
    expect(find.text('100'), findsOneWidget);

    // Tap the "Pay Now" button.
    await tester.tap(find.text('Pay Now'));
    await tester.pump();

    // Since UPI redirection cannot be tested in a widget test,
    // you can check for a snack bar or an error message if validation fails.
    expect(find.byType(SnackBar), findsNothing); // Replace with your test conditions
  });
}
