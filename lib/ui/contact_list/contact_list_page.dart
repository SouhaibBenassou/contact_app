import 'package:contact_app/ui/contact_list/model/contacts_model.dart';
import 'package:contact_app/ui/contact_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  // underscore acts like a private access modifier

// Runs when the state changes
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 234, 113, 255),
          title: const Text('Contact')),
      body: ScopedModelDescendant<ContactModel>(
        builder: (context, chlid, model) {
          return ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(
                contactIndex: index,

                // Takes in higher order function which  gets passed tow contacts
              );
            },
          );
        },
      ),
    ));
  }
}
