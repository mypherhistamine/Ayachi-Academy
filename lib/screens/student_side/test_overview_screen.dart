import 'package:TestGround/models/student_side/question.dart';
// import 'package:TestGround/screens/student_side/profile.dart';

import 'package:TestGround/widgets/student_side/appDrawer.dart';
import 'package:TestGround/widgets/student_side/questionPaper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:get/get.dart';

class TestOverviewScreen extends StatefulWidget {
  static const routeName = 'overViewscreen';
  final userId;
  const TestOverviewScreen({Key key, this.userId}) : super(key: key);
  @override
  _TestOverviewScreenState createState() => _TestOverviewScreenState();
}

class _TestOverviewScreenState extends State<TestOverviewScreen> {
  int pageIndex = 0;
  bool isRefreshing = false;

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((value) => () {
  //         // final data = Provider.of<QuestionPaper>(context, listen: false);
  //       });
  //   print('User ID: ${widget.userId}');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuestionPaper>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                isRefreshing = true;
              });
              // await data.getQuestionPapers(userId: widget.userId);
              setState(() {
                isRefreshing = false;
              });
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        width: double.infinity,
        // margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: isRefreshing
            ? Center(child: Text('Refreshing'))
            : FutureBuilder(
                future: data.getQuestionPapers(userId: widget.userId),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // else if (snapshot.hasData == null || snapshot.data == '') {
                  //   return Center(
                  //     child: Text('Looks like there are no tests right now !'),
                  //   );
                  // }
                  else if (snapshot.connectionState == ConnectionState.done) {
                    return buildListView(snapshot);
                  }
                  return buildListView(snapshot);
                },
              ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index) {
      //     setState(() {
      //       pageIndex = index;
      //     });
      //     switch (index) {
      //       case 0:
      //         Get.to(TestOverviewScreen());
      //         break;
      //       case 1:
      //         Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(builder: (ctx) => Profile()));
      //         break;
      //     }
      //   },
      //   currentIndex: pageIndex, // this will be set when a new tab is tapped
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: new Icon(Icons.home),
      //       title: new Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text('Profile'),
      //     ),
      //   ],
      // ),
    );
  }

  ListView buildListView(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        // print(snapshot.data[i]);
        return snapshot.hasData
            ? QuestionPaperWidget(data: snapshot.data[i])
            : Center(
                child: Text('No tests!'),
              );
      },
      itemCount: snapshot.hasData ? snapshot.data.length : 0,
    );
  }
}
