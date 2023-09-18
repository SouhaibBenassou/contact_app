import 'package:contact_app/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactModel extends Model {
  // underscore acts like  private access modifier
  List<Contact> _contacts = List.generate(
      50,
      (index) => Contact(
          name: faker.person.firstName() + '' + faker.person.lastName(),
          email: faker.internet.freeEmail(),
          phoneNumber: faker.randomGenerator.integer(1000000).toString()));

// Get only proprety , makes sure that we connot overwrite contacts
// from different classes
  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _contacts.sort((a, b) {
      if (a.isFavorite) {
        // contactOne will be BEFORE contactTwo
        return -1;
      } else if (b.isFavorite) {
        // contactOne will be after contactTwo
        return 1;
      } else {
        // The position doesn't change
        return 0;
      }
    });
    notifyListeners();
  }
}
