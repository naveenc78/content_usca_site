import 'package:content_example/Services/storage_service.dart';
import 'package:flutter/material.dart';
import 'Screens/homepage_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StorageService(),
      child: MaterialApp(
        title: 'USCA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          //brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],

          // Define the default font family.
          fontFamily: 'Open Sans',

          // // Define the default `TextTheme`. Use this to specify the default
          // // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText1: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          // add tabBarTheme
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              labelStyle: TextStyle(
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // color for text
              indicator: UnderlineTabIndicator(
                  // color for indicator (underline)
                  borderSide: BorderSide(width: 3.0, color: Colors.white))),
          //primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'United States Carrom Association'),
      ),
    );
  }
}
