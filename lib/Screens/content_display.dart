import 'package:flutter/material.dart';
import 'package:collapsible/collapsible.dart';
import 'package:content_example/Screens/content_sidebar.dart';
import 'package:content_example/Screens/content_detail.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';

class ContentDisplay extends StatefulWidget {
  const ContentDisplay({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<ContentDisplay> createState() => _ContentDisplayState();
}

class _ContentDisplayState extends State<ContentDisplay> {
  // this boolean controls the collapsible widget
  bool _collapsed = false;

  @override
  void initState() {
    final storageservice = Provider.of<StorageService>(context, listen: false);
    storageservice.setReference(widget.title);
    _collapsed = (storageservice.getCurrentItems() == null)
        ? true
        : (storageservice.getCurrentItems()!.length > 1)
            ? false
            : true;
    super.initState();
  }

  void _toggleCollapsible() {
    _collapsed = !_collapsed;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Collapsible(
            child: const ContentSideBar(),
            collapsed: _collapsed,
            axis: CollapsibleAxis.both,
            maintainAnimation: true,
            maintainState: true,
            fade: true,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 2.0,
                primary: Colors.blue[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
            //color: Colors.red,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: _toggleCollapsible,
            child:
                Icon(_collapsed ? Icons.close_fullscreen : Icons.open_in_full),
          ),

          //separation between left and right pane
          const SizedBox(width: 80.0),

          //add a ui / html renderer element
          const ContentDetail(),
          // const Spacer(),
        ],
      ),
    );
  }
}
