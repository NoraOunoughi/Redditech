import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:redditech_lucas_nora/Searches/search.dart';
import 'package:redditech_lucas_nora/Searches/subredditsearch.dart';
import 'package:redditech_lucas_nora/Searches/designcardsearch.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchValue = TextEditingController();
  bool isSubredditSearch = false;
  List<SubredditSearch> allSubredditSearch = [];

  onItemChanged(String value) async {
    allSubredditSearch.clear();
    allSubredditSearch = await getSubredditWithNameSearch(value);
    isSubredditSearch = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text("Search Page"),
                leading: const Icon(Icons.search),
                backgroundColor: Colors.blue,
                ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      offset: Offset(1,1),
                                    ),
                                  ]
                                ),
                                  child: TextField(
                                    onChanged: (value) async { await onItemChanged(value); },
                                    controller: searchValue,
                                    decoration: InputDecoration(
                                        labelText: "Search",
                                        hintText: "Search /r",
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        isSubredditSearch == true ? showPost(context)
                          : Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.4),
                          child: Container(),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      );
  }

  Widget showPost(var context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        allSubredditSearch.length,
            (index) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: mycardSubSearch(
              context, allSubredditSearch[index])),
      ),
    );
  }
}
