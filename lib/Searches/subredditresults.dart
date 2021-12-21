import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redditech_lucas_nora/Subscribe/subscribe.dart';
import 'package:redditech_lucas_nora/Searches/search.dart';
import 'package:redditech_lucas_nora/Searches/subredditsearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redditech_lucas_nora/TimeLine/thread.dart';
import 'package:redditech_lucas_nora/TimeLine/designcard.dart';
import 'package:redditech_lucas_nora/TimeLine/postobj.dart';

class SearchResultsPage extends StatefulWidget {
  final String name;
  const SearchResultsPage(this.name);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final _storage = new FlutterSecureStorage();
  SubredditSearch subreddit = SubredditSearch(
      keyColor: "blue",
      name: "none",
      title: "test",
      description: "test",
      subscriberCount: 1,
      iconImg: "try",
      headerImg: "test",
      activeUserCount: 1,
      isUserSubscribe: false);
  bool postExists = false;
  String currentpost = 'hot';
  List<myRedditPost> listmyRedditPosts = [];
  late ListingPost listing;

  getSubmyRedditPost({String? name = "", String sortParam = "", String start = "", String end = "", int count = 0}) async {
     if (name != null && name != "") {
       HandleListing listingParam = HandleListing(start: start, end: end, count: count);
       listing = await getPosts(name, sortParam, listingParam);
       listmyRedditPosts = listing.allPosts;
       postExists = true;
       setState(() {});
     }
   }

  getSub() async {
    subreddit = await getSubredditWithName(widget.name);
    await getSubmyRedditPost(name: widget.name, sortParam: currentpost);
    setState(() {});
  }

  onSelected(BuildContext context, int item) async {
    switch (item) {
      case 1:
        currentpost = "hot";
        await getSubmyRedditPost(name: subreddit.name, sortParam: currentpost);
        break;
      case 2:
        currentpost = "new";
        await getSubmyRedditPost(name: subreddit.name, sortParam: currentpost);
        break;
      case 3:
        currentpost = "top";
        await getSubmyRedditPost(name: subreddit.name, sortParam: currentpost);
        break;
      case 4:
        currentpost = "best";
        await getSubmyRedditPost(name: subreddit.name, sortParam: currentpost);
        break;
    }
  }
  @override
  void initState() {
    getSub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: Icon(Icons.image_search_rounded),
              onPressed: () => Navigator.of(context).pop()),
          elevation: 0,
          title: Container(
            padding: EdgeInsets.only(left: 30),
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.sentiment_very_satisfied_outlined),
                  const SizedBox(width: 10),
                  subreddit.name != null
                      ? Text("r/" + subreddit.name.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ))
                      : Container(),
                ],
              ),
            ),
          ),
          actions: [
            PopupMenuButton<int>(
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
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              subreddit.description != null ? buildHeader() : Container(),
              buildIcon(),
              subreddit.description != null ? buildbio() : Container(),
              postExists ? showPost(MediaQuery.of(context).size.width) : Container(),
              Row(
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width /
                      3),
                  buildBeforeButton(),
                  buildNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildHeader() => Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(subreddit.headerImg.toString()),
          ),
        ),
      );

  Widget buildIcon() => Container(
        transform: Matrix4.translationValues(0.0, -40.0, 0.0),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: subreddit.iconImg != null
                      ? NetworkImage(subreddit.iconImg.toString())
                      : null,
                ),
                Container(
                  width: 100,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: subreddit.isUserSubscribe ? Colors.red : Colors.lightBlue,
                      border: Border.all(color: Colors.black)),
                  child: subreddit.isUserSubscribe == false
                       ? TextButton(
                          child: Center (child: Text(
                                "Sub",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                          onPressed: () async {
                            await subtosubreddit(subreddit.name.toString());
                            getSub();
                          },
                        ) 
                      : TextButton(child:
                        Center (child: Text(
                          "Unsub",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await unsubtosubreddit(subreddit.name.toString());
                        getSub();
                      }
                    ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "/" + subreddit.name.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                subreddit.subscriberCount != null
                    ? Text(
                        subreddit.subscriberCount.toString() + " members",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                        ),
                      )
                    : SizedBox(),
                SizedBox(width: 20),
                subreddit.activeUserCount != null
                    ? Text(
                        subreddit.activeUserCount.toString() + " online",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      );
  
  Widget buildbio() {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            subreddit.description == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Container(
                      height: 200,
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          subreddit.description.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildBeforeButton() {
    return Container(
      margin: EdgeInsets.all(10),
      width: 40.0,
      height: 40.0,
      child: FlatButton(
        child: Icon(Icons.arrow_back_ios,color: Colors.white),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        onPressed: () async {
          getSubmyRedditPost(name : subreddit.name, sortParam : currentpost, start: listing.start.toString(), count: listing.count - 10);
        },
      ),
    );
  }

  Widget buildNextButton() {
    return Container(
      width: 40.0,
      height: 40.0,
      margin: EdgeInsets.all(10),
      child: FlatButton(
        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        onPressed: () async {
          getSubmyRedditPost(name : subreddit.name, sortParam : currentpost, start: listing.end.toString(), count: listing.count + 10);
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