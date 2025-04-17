import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdatePage extends StatefulWidget {
  final Contact contact;
  final int index;
  const UpdatePage({super.key, required this.contact, required this.index});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
   TextEditingController _controllerName = TextEditingController();
   TextEditingController _controllerNumber = TextEditingController();

  @override
  void initState() {
    _controllerName = TextEditingController(text: widget.contact.name);
    _controllerNumber = TextEditingController(text: widget.contact.number);
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
              InputDecoration(labelText: "Number"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,

              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Contact updateContact = Contact(
                    name: _controllerName.text, number: _controllerNumber.text);
                Navigator.pop(
                  context,
                  {"contact" : updateContact, "index" :widget.index},
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
