import 'package:flutter/material.dart';
import 'package:content_example/Screens/content_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentSideBar extends StatelessWidget {
  const ContentSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide <= 600)
        ? (MediaQuery.of(context).size.height * 0.6)
        : (MediaQuery.of(context).size.shortestSide * 0.6);
    double width = (MediaQuery.of(context).size.shortestSide <= 600)
        ? size * 0.5
        : size * 0.4;

    return Container(
        //duration: Duration.secondsPerMinute.,
        width: width,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.blue[100],
        ),
        //child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(8.sp, 25.sp, 8.sp, 8.sp),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: size * 0.95),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Expanded(
                    child: ContentList(),
                  ),
                ],
              ),
            )));
  }
}
