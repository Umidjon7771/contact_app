import 'package:contact_app/model/model.dart';
import 'package:contact_app/pages/add_page.dart';
import 'package:contact_app/pages/update_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../contact_provider.dart';



class Home extends StatefulWidget {
  final ContactProvider provider;
  const Home({super.key, required this.provider});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  bool isPressed = false;


  @override
  void initState() {
    _controller;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            widget.provider.addContact(newContact);
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
              onChanged: widget.provider.filterContact,
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
                      widget.provider.contact
                          .sort((a, b) => a.name.compareTo(b.name));
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
                      widget.provider.contact
                          .sort((a, b) => b.name.compareTo(a.name));
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
              child: ListenableBuilder(
                listenable: widget.provider,
                builder: (context, _) {
                  return ListView.builder(
                    itemCount: widget.provider.contact.length,
                    itemBuilder: (context, index) {
                      final contact = widget.provider.contact[index];
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
                                  onPressed: () async{
                                    final result =  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdatePage(
                                          contact: widget.provider.contact[index],
                                          index: index,
                                        ),
                                      ),
                                    );
                                    if(result != null){
                                      final updatedContact = result["contact"];
                                      final index = result["index"];
                                      widget.provider.updateContact(index,updatedContact);
                                    }
                                  },
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
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    MaterialButton(
                                                      height: 50,
                                                      minWidth: 100,
                                                      color:
                                                      Colors.grey.shade100,
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
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 40,
                                                    ),
                                                    MaterialButton(
                                                      height: 50,
                                                      minWidth: 100,
                                                      color:
                                                      Colors.blue.shade900,
                                                      onPressed: () {
                                                        widget.provider
                                                            .deleteContact(
                                                            index);
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