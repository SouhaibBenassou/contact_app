import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact_list/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  const ContactEditPage(
      {required this.editedContact,
      required this.editedContactIndex,
      super.key});

  final Contact editedContact;
  final int editedContactIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
        ),
        body: ContactForm(
          editedContact: editedContact,
          editedContactIndex: editedContactIndex,
        ));
  }
}
