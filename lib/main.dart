import 'package:contact_app/model/model.dart';
import 'package:contact_app/pages/add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.workSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  bool isPressed = false;

  List<Contact> _filteredContacts = [];

  List<Contact> _contact = [
    Contact(
      name: "Umidjon",
      number: "+998-345-95-65",
    ),
    Contact(
      name: "Alisher",
      number: "+998-001-01-01",
    ),
    Contact(
      name: "Aziz",
      number: "+998-002-02-02",
    ),
  ];

  void _add(Contact contact) {
    setState(() {
      _contact.add(contact);
    });
  }

  @override
  void initState() {
    _filteredContacts = _contact;
    super.initState();
  }

  void filterContact(String name) {
    final filtered = _contact.where((contact) {
      return contact.name.toLowerCase().contains(name.toLowerCase());
    }).toList();

    setState(() {
      _filteredContacts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Contact newContact = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );

          if (newContact != null) {
            _add(newContact);
          }
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Contact"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: filterContact,
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Search...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    if (isPressed = !isPressed) {
                      _contact.sort((a, b) => a.name.compareTo(b.name));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 300),
                          content: Text("Sorted by alphabit"),
                        ),
                      );
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 300),
                          content: Text("Default..."),
                        ),
                      );
                      _contact.sort((a, b) => b.name.compareTo(a.name));
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.sort_down,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = _filteredContacts[index];
                  return SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Card(
                      color: Colors.grey.shade300,
                      child: ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.pen),
                            ),
                            IconButton(
                              onPressed: () {
                                /// dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        height: 200,
                                        width: 400,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              "Delete Contact",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Are you sure you want to delete contact?",
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                MaterialButton(
                                                  height: 50,
                                                  minWidth: 100,
                                                  color: Colors.grey.shade100,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "  Cancel  ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                MaterialButton(
                                                  height: 50,
                                                  minWidth: 100,
                                                  color: Colors.blue.shade900,
                                                  onPressed: () {
                                                    _contact.removeAt(index);
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "  Yes  ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.delete,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.phone),
                            ),
                          ],
                        ),
                        title: Text(
                          contact.name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          contact.number,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
