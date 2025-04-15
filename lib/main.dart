import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contact_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactProvider contactProvider = ContactProvider();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.workSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(
        provider: contactProvider,
      ),
    );
  }
}

class InheritedData extends InheritedWidget {
  final Contact contact;
  const InheritedData({
    super.key,
    required super.child,
    required this.contact,
  });

  static InheritedData of(BuildContext context) {
    final InheritedData? result =
        context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedData old) {
    return true;
  }
}
