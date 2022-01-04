import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:content_example/Screens/content_display.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const List<Tab> contentTabs = <Tab>[
    Tab(text: 'Pavilion', icon: Icon(Icons.home)),
    Tab(text: 'Latest Buzz', icon: Icon(Icons.network_wifi_sharp)),
    Tab(text: 'Leaderboard', icon: Icon(Icons.leaderboard)),
    Tab(text: 'Blogs', icon: Icon(Icons.article)),
    Tab(text: 'Sponsors', icon: Icon(Icons.money)),
  ];

  // this is the mapping from display name to storage folders
  static const Map<String, String> storagerefmap = {
    "Pavilion": "Pavilion",
    "Latest Buzz": "News",
    "Leaderboard": "Rankings",
    "Blogs": "Blogs",
    "Sponsors": "Sponsors"
  };

  late TabController _tabController;

  // this is the tab status bar
  TabBar get _tabBar => TabBar(
        controller: _tabController,
        tabs: contentTabs,
      );

  String getStorageReference(int index) {
    if (storagerefmap[contentTabs[index].text!] == null) {
      return "USCA";
    }
    return "USCA/" + storagerefmap[contentTabs[index].text!]!;
  }

  // set up initState and dispose of the stateful widget, retrieving the provider and listening to changes
  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: contentTabs.length, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800], // color of app bar
        toolbarHeight: 80,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        title: buildtitle(),
        centerTitle: true,
        // leading: const Icon(Icons.menu),
        actions: buildactions(),
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: ColoredBox(
            color: Colors.blue,
            child: _tabBar,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ContentDisplay(title: getStorageReference(0)),
          ContentDisplay(title: getStorageReference(1)),
          ContentDisplay(title: getStorageReference(2)),
          ContentDisplay(title: getStorageReference(3)),
          ContentDisplay(title: getStorageReference(4)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[100],
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Play With Us',
        child: const Icon(Icons.play_circle_fill),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //the title widget with logo, title and sub title
  Widget buildtitle() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 5.0),
            Container(
                width: 150.0,
                height: 400.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('icons/logo.png')))),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5.0),
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 2.0),
                const Text('               where Passion meets Perfection',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //build actions widgets on the title bar
  List<Widget>? buildactions() {
    return <Widget>[
      // Transform.scale(
      //   scale: 1.25,
      //   child: IconButton(
      //     icon: const Icon(Icons.more_vert_outlined),
      //     onPressed: () {},
      //   ),
      //),
      (FirebaseAuth.instance.currentUser == null)
          ? Transform.scale(
              scale: 1.25,
              child: IconButton(
                icon: const Icon(Icons.account_circle_rounded),
                onPressed: () {},
              ),
            )
          : Transform.scale(
              scale: 1.25,
              child: IconButton(
                icon: const Icon(Icons.account_tree_rounded),
                onPressed: () {},
              ),
            ),
      const SizedBox(width: 10.0),
    ];
  }
}
