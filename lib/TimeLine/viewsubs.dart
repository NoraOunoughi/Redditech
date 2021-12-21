import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redditech_lucas_nora/TimeLine/postobj.dart';
import 'package:redditech_lucas_nora/TimeLine/thread.dart';
import 'package:redditech_lucas_nora/TimeLine/designcard.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';


class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  late ListingPost listing;
  bool postExists = false;
  String currentpost = "";
  List<myRedditPost> listmyRedditPosts = [];

  getPagePosts({String sortParam = "hot", String start = "", String end = "", int count = 0}) async {
    HandleListing listingParam = HandleListing(start: start, end: end, count: count);
    listing = await getPosts("", sortParam, listingParam);
    listmyRedditPosts = listing.allPosts;
    postExists = true;
    setState(() {});
  }

  onSelected(BuildContext context, int item) async {
    switch (item) {
      case 1:
        currentpost = "hot";
        await getPagePosts(sortParam: currentpost);
        break;
      case 2:
        currentpost = "new";
        await getPagePosts(sortParam: currentpost);
        break;
      case 3:
        currentpost = "top";
        await getPagePosts(sortParam: currentpost);
        break;
      case 4:
        currentpost = "best";
        await getPagePosts(sortParam: currentpost);
        break;
    }
  }
  @override
  void initState() {
    getPagePosts(sortParam: "hot");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(backgroundColor: Colors.blue,
                  leading: Icon(Icons.home),
                  title: Text("Filter"),
                  centerTitle: true,
                  actions: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.white,
                        iconTheme: IconThemeData(color: Colors.white),
                        textTheme: TextTheme().apply(bodyColor: Colors.white),
                      ),
                      child: PopupMenuButton<int>(
                        color: Colors.blueAccent,
                        onSelected: (item) async => await onSelected(context, item),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.local_fire_department_sharp),
                                const SizedBox(width: 8),
                                Text('Hot'),
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.fiber_new_outlined),
                                const SizedBox(width: 8),
                                Text('New'),
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: Row(
                                children: [
                                Icon(Icons.arrow_circle_up),
                            const SizedBox(width: 8),
                            Text('Top'),
                            ],
                          ),
                          ),
                          PopupMenuItem<int>(
                            value: 4,
                            child: Row(
                              children: [
                                Icon(Icons.auto_graph_sharp),
                                const SizedBox(width: 8),
                                Text('Best'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        postExists == true
                            ? showPost(MediaQuery.of(context).size.width)
                            : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height /
                                  2.4),
                          child: Text("Loading..."),
                        ),
                      ],
                    ),
                    postExists == true
                        ? Row (
                        children: <Widget>[
                          SizedBox(width: MediaQuery.of(context).size.width /
                          3.8),
                          _loadBeforeButton(context),
                          _loadNextButton(context),
                        ]
                    ) : Container(),
                  ],
                ),
              ),
              //bottomNavigationBar: myBottomAppBar(context),
              ),
      ),
    );
  }
  Widget _loadNextButton(var context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 50.0,
      height: 50.0,
      child: FlatButton(
        child: Icon(Icons.arrow_forward_ios,color: Colors.white),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        onPressed: () async {
          getPagePosts(sortParam: currentpost, end: listing.end.toString(), count: listing.count + 10);
        },
      ),
    );
  }

  Widget _loadBeforeButton(var context) {
    return Container(
      width: 50.0,
      height: 50.0,
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Icon(Icons.arrow_back_ios,color: Colors.white,),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        onPressed: () async {
          getPagePosts(sortParam: currentpost, start: listing.start.toString(), count: listing.count - 10);
        },
      ),
    );
  }
  Widget showPost(double finalWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        listmyRedditPosts.length,
            (index) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: mycardPost(
                listmyRedditPosts[index])),
      ),
    );
  }
}