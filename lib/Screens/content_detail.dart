import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';
import 'package:content_example/Screens/html_view.dart';

class ContentDetail extends StatelessWidget {
  const ContentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This gets the current state of contents and also tells Flutter
    // to rebuild this widget when content notifies listeners (in other words,
    // when it changes).
    var contents = context.watch<StorageService>();

    return (contents.getCurrentItem() == null)
        ? Center(
            child: Text('Content will be available soon. Stay Tuned!',
                style: Theme.of(context).textTheme.headline6))
        : (contents.getCurrentDownloadUrl().isEmpty)
            ? FutureBuilder(
                future: contents.fetchCurrentDownloadUrl(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("${snapshot.error}",
                              style: Theme.of(context).textTheme.bodyText1));
                    } else {
                      return Center(
                          child: IframeView(
                              source: snapshot.data!,
                              width: MediaQuery.of(context).size.shortestSide *
                                  .95,
                              height: MediaQuery.of(context).size.height));
                    }
                  }

                  return const Center(child: CircularProgressIndicator());
                })
            : Center(
                child: IframeView(
                    source: contents.getCurrentDownloadUrl(),
                    width: MediaQuery.of(context).size.shortestSide * .95,
                    height: MediaQuery.of(context).size.height));
  }
}

// Sample template widgets for future use
                 // return showdetail(
                  //     contents.getCurrentItem()!.name,
                  //     '',
                  //     snapshot.data!,
                  //     MediaQuery.of(context).size.height,
                  //     MediaQuery.of(context).size.shortestSide * 0.6,
                  //     contents.logger);
 
  // widget to show the detail view
  // Widget showdetail(String itemname, String itemurl, Uint8List itemdata,
  //     double widgetheight, double widgetwidth, Logger log) {
  //   log.d('Item: ' + itemname);
  //   log.d('ItemURL: ' + itemurl);

  //   if (itemname.endsWith('.pdf')) {
  //     final pdfController = PdfController(
  //       document: PdfDocument.openData(itemdata),
  //     );

  //     return SizedBox(
  //         width: widgetwidth,
  //         height: widgetheight,
  //         child: Expanded(
  //             child: ListView(
  //                 shrinkWrap: true,
  //                 children: [PdfView(controller: pdfController)])));
  //   }

  //   return const Center(child: Text('Ooo - really close. Stay Tuned!'));
    //for all other files return this
//     return Expanded(
//         child: SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       controller: _scrollController,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(4.0, 20.0, 20.0, 10.0),
// //        child: ConstrainedBox(
// //          constraints:
// //              BoxConstraints(maxHeight: widgetheight, maxWidth: widgetwidth),
// //          child: Column(
// //            mainAxisAlignment: MainAxisAlignment.start,
// //            crossAxisAlignment: CrossAxisAlignment.stretch,
// //            children: <Widget>[
// //              Flexible(
//         child: EasyWebView(
//             src: itemurl,
//             onLoaded: () {
//               log.d('Web View loaded');
//             }),
//         //             ),
//         //           ],
//         //         ),
// //        ),
//       ),
//     ));
  // }

