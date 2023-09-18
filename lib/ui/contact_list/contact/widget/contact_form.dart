import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact_list/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _fromKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: _validateName,
            // The validator receives the text that the user has entered.
            onSaved: (value) => _name = value ?? '',
            decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: _validateEmail,
            onSaved: (value) => _email = value ?? '',
            decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: _validatePhoneNumber,
            onSaved: (value) => _phoneNumber = value ?? '',
            decoration: InputDecoration(
                labelText: 'phoneNumber',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                onSavedContactButtonPressed();
              },
              child: const Row(
                children: [
                  Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.person,
                    size: 18,
                  )
                ],
              ))
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Enter a name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value!.isEmpty) {
      return 'Enter a Email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    final emailRegex = RegExp(r"^(?:[+0]9)?[0-9]{10}$");
    if (value!.isEmpty) {
      return 'Enter a phone number';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a phone number';
    }
    return null;
  }

  void onSavedContactButtonPressed() {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState!.save();
      final newContact = Contact(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
      );
      ScopedModel.of<ContactModel>(context).addContact(newContact);
    }
  }
}
