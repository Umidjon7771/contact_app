import 'package:flutter/material.dart';
import 'model/model.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contact = [
    Contact(
      name: "Umid",
      number: "+998-000-00-00",
    ),
    Contact(
      name: "Alisher",
      number: "+998-001-01-01",
    ),
    Contact(
      name: "Aziz",
      number: "+998-002-02-02",
    ),

    Contact(
      name: "Shavkat",
      number: "+998-007-07-07",
    ),


  ];

  List<Contact> _filteredContacts = [];

  List<Contact> get filteredContacts => _filteredContacts;

  void initializeFilteredContacts() {
    _filteredContacts = List.from(contact);
    notifyListeners();
  }

  void addContact(Contact newContact) {
    contact.add(newContact);
    // Also update filtered contacts to maintain consistency
    _filteredContacts = List.from(contact);
    notifyListeners();
  }

  void deleteContact(int index) {
    final deletedContact = contact[index];
    contact.removeAt(index);

    _filteredContacts.removeWhere((c) =>
    c.name == deletedContact.name && c.number == deletedContact.number);

    notifyListeners();
  }

  void updateContact(int index, Contact newContact) {
    contact[index] = newContact;

    _filteredContacts = filterWithCurrentQuery();
    notifyListeners();
  }

  String _currentSearchQuery = '';

  void filterContact(String query) {
    _currentSearchQuery = query;
    _filteredContacts = filterWithCurrentQuery();
    notifyListeners();
  }

  List<Contact> filterWithCurrentQuery() {
    if (_currentSearchQuery.isEmpty) {
      return List.from(contact);
    }

    return contact.where((contact) {
      return contact.name.toLowerCase().contains(_currentSearchQuery.toLowerCase());
    }).toList();
  }

  void sortContact() {
    contact.sort((a, b) => a.name.compareTo(b.name));
    _filteredContacts = filterWithCurrentQuery();
    notifyListeners();
  }


  void defaultContact() {
    contact.sort((a, b) => b.name.compareTo(a.name));
    _filteredContacts = filterWithCurrentQuery();
    notifyListeners();
  }
}