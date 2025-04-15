import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();

  @override
  void initState() {
    _controllerName;
    _controllerNumber;
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerName,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controllerNumber,
              decoration:
                  InputDecoration(labelText: "Number", prefixText: "+998 - "),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Contact addContact = Contact(
                    name: _controllerName.text, number: _controllerNumber.text);
                Navigator.pop(
                  context,
                  addContact,
                );
              },
              child: Text(
                "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
