import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:content_example/Screens/content_display.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const memberurl = 'https://www.uscarrom.org/membership-details/';
const donateurl =
    'https://www.paypal.com/donate/?hosted_button_id=9SQ5CST8FTGE6';
const tourneyurl = 'https://www.uscarrom.org/tournament/';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.tab,
      required this.pparam,
      required this.data})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String tab;
  final String pparam;
  final Object? data;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

// this is a public class so the global key can be accessed from outside
class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const List<Tab> contentTabs = <Tab>[
    Tab(text: 'Buzz', icon: Icon(Icons.network_wifi_sharp)),
  ];

  // this is the mapping from display name to storage folders
  static const Map<String, String> storagerefmap = {
    "Buzz": "News",
  };

  int initialselection = 0;

  String getStorageReference(int index) {
    if (storagerefmap[contentTabs[index].text!] == null) {
      return "USCA";
    }
    return "USCA/" + storagerefmap[contentTabs[index].text!]!;
  }

  // set up initState and dispose of the stateful widget, retrieving the provider and listening to changes
  @override
  void initState() {
    int index = 0;
    if (widget.tab.isNotEmpty) {
      index = contentTabs.indexWhere((tab) => tab.text!.contains(widget.tab));
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blue[800], // color of app bar
        toolbarHeight: height * 0.1,
        leadingWidth: width * 0.15,
        // lead with the logo, if you need a menu bar, this can be moved to title
        leading: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        title: Text(widget.title,
            style: TextStyle(
                fontSize: (width <= 600) ? 15 : 20,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),

        centerTitle: true,
        actions: buildactions(context),
      ),
      body: Column(
        children: <Widget>[
          ContentDisplay(title: getStorageReference(0), itemID: widget.pparam),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[100],
        shape: const CircularNotchedRectangle(),
        child: buildBottomBar(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchURL(tourneyurl);
        },
        tooltip: 'Play With / Follow Us',
        child: const Icon(Icons.play_circle_fill),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // method to build the bottom nav bar
  Widget buildBottomBar(context) {
    return Container(
      height: 50, //0.065.sh,
      child: Row(
        children: <Widget>[
          const Spacer(),
          Tooltip(
              message: 'Become a USCA Member',
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.wallet_membership_outlined),
                  style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp))),
                  onPressed: () {
                    _launchURL(memberurl);
                  },
                  label:
                      const Text('Join Us', style: TextStyle(fontSize: 14.0)))),
          const Spacer(),
          (MediaQuery.of(context).size.width >= 600)
              ? const Text('\n\n@Copyright USCA 2022.',
                  style: TextStyle(fontSize: 9.0))
              : const Text(''),
          const Spacer(),
          Tooltip(
              message: 'Give to the sport you love in just a click. Thank you!',
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.attach_money_outlined),
                  style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    _launchURL(donateurl);
                  },
                  label: const Text('Donate', style: TextStyle(fontSize: 14)))),
          const Spacer(),
        ],
      ),
    );
  }

  //build actions widgets on the title bar
  List<Widget>? buildactions(BuildContext context) {
    return <Widget>[
      Transform.scale(
        scale: 1.25,
        child: IconButton(
          icon: const Icon(Icons.account_box_rounded),
          onPressed: () {},
          tooltip: 'Sign In - Coming Soon',
        ),
      ),
      (MediaQuery.of(context).size.width <= 600)
          ? const SizedBox(width: 5)
          : const SizedBox(width: 15),
    ];
  }

  // Launch URL
  void _launchURL(String url) async {
    await launch(url);
  }
}
