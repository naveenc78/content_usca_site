import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';

class ContentList extends StatelessWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.bodyText1;
    // This gets the current state of contents and also tells Flutter
    // to rebuild this widget when content notifies listeners (in other words,
    // when it changes).
    var contents = context.watch<StorageService>();

    return (contents.getCurrentItems() == null)
        ? Center(
            child: Text('Contents will be available soon. Stay Tuned!',
                style: itemNameStyle))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: contents.getCurrentItems()!.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                contents.setSelectedItem(index);
              },
              tileColor: Colors.blue[200],
              selectedColor: Colors.blue[900],
              //leading: const Icon(Icons.notes_outlined),
              title: Text(
                contents.getCurrentItems()![index].name.split('.')[0],
                style: itemNameStyle,
              ),
            ),
          );
  }
}
