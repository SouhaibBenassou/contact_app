class Contact {
  String name;
  String email;
// String - not all phone numbers are valid mathemtical numbers
  String phoneNumber;
  bool isFavorite;

// Constructor with optional named parameters
  Contact({
    // required annotation makes sure that an optional parameter is actually passed in
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
  });
}
