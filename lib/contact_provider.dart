import 'package:flutter/material.dart';

import 'model/model.dart';

class ContactProvider extends ChangeNotifier{
  List<Contact> contact = [
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

  List<Contact> _filteredContacts = [];

  List<Contact> get filteredContacts => _filteredContacts;

  void addContact(Contact newContact) {
      contact.add(newContact);
    notifyListeners();
  }

  void deleteContact(int index) {
    contact.removeAt(index);

    notifyListeners();
  }

  void updateContact(int index, Contact newContact){
   contact[index] = newContact;

   _filteredContacts = List.from(contact);
   notifyListeners();
  }



  void filterContact(String name) {
    final filtered = contact.where((contact) {
      return contact.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
      _filteredContacts = filtered;
      notifyListeners();
  }
}