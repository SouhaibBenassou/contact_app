import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact_list/contact/contact_edit_page.dart';
import 'package:contact_app/ui/contact_list/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contactIndex,
  });
  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    // If yo don't need to rebulid the widget tree once the model's data changes
    // (when yo only make changes to the model,like in this ContactCard),
    // you don't need to use ScopedModelDescendant with bulider,but only simply
    // call Scopedmodel.of<T>() function
    return ScopedModelDescendant<ContactModel>(
      builder: (context, child, model) {
        final displayContact = model.contacts[contactIndex];
        return Slidable(
          key: ValueKey(0),
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                model.deleteContact(contactIndex);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  model.deleteContact(contactIndex);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),

              // A SlidableAction can have an icon and/or a label.
            ],
          ),
          child: _bulidContent(
            context,
            displayContact,
            model,
          ),
        );
      },
    );
  }

  Container _bulidContent(
    BuildContext context,
    Contact displayContact,
    ContactModel model,
  ) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListTile(
          leading: Hero(
            tag: ,
              child: CircleAvatar(
            child: Text(displayContact.name[0]),
          )),
          onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ContactEditPage(
                    editedContact: displayContact,
                    editedContactIndex: contactIndex,
                  ),
                ))
              },
          title: Text(
            displayContact.name,
          ),
          subtitle: Text(
            displayContact.email,
          ),
          trailing: IconButton(
            onPressed: () {
              model.changeFavoriteStatus(contactIndex);
            },
            icon: Icon(
              displayContact.isFavorite ? Icons.star : Icons.star_border,
              color: displayContact.isFavorite ? Colors.amber : Colors.grey,
            ),
          )),
    );
  }
}
