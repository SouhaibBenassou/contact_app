import 'package:contact_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;

class ContactListPage extends StatelessWidget {
  
  // underscore acts like a private access modifier
  List<Contact> _contacts = List.generate(50, (index) => Contact(name: faker.Person()., email: email, phoneNumber: phoneNumber));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Contact'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Text(
              's',
              style: TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}
