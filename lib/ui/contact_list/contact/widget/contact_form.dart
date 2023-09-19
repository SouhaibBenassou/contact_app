import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact_list/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({this.editedContact, this.editedContactIndex, super.key});

  final Contact? editedContact;
  final int? editedContactIndex;
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _fromKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  bool get isEditedMode => widget.editedContact != null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          _bulidContactPicture(),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: widget.editedContact?.name,
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
            initialValue: widget.editedContact?.email,
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
            initialValue: widget.editedContact?.phoneNumber,
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
                _onSavedContactButtonPressed();
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

  Widget _bulidContactPicture() {
    final halfScrennDimeter = MediaQuery.of(context).size.width / 2;
    return CircleAvatar(
      radius: halfScrennDimeter / 2,
      child: _bulidCirleAvatar(halfScrennDimeter),
    );
  }

  Widget _bulidCirleAvatar(double halfScrennDimeter) {
    if (isEditedMode) {
      return Text(
        widget.editedContact!.name[2],
        style: TextStyle(fontSize: halfScrennDimeter / 2),
      );
    } else {
      return Icon(
        Icons.person,
        size: halfScrennDimeter / 2,
      );
    }
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
    final phoneNumberRegex = RegExp(
        r'^[0-9-()+\s]+$'); // Matches digits, dashes, parentheses, plus signs, and spaces
    if (value!.isEmpty) {
      return 'Enter a phone number';
    } else if (!phoneNumberRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _onSavedContactButtonPressed() {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState!.save();
      final newOrEditedContact = Contact(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
        isFavorite: widget.editedContact?.isFavorite ?? false,
      );

      if (isEditedMode) {
        if (widget.editedContactIndex != null) {
          // Determine the edited contact index from the widget property
          final editedIndex = widget.editedContactIndex!;
          ScopedModel.of<ContactModel>(context)
              .updateContact(newOrEditedContact, editedIndex);
        }
      } else {
        ScopedModel.of<ContactModel>(context).addContact(newOrEditedContact);
      }
      Navigator.of(context).pop();
    }
  }
}
