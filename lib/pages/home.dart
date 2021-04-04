import 'dart:async';
import 'package:arstechnica_fschmtz/classes/feed.dart';
import 'package:arstechnica_fschmtz/configs/configs.dart';
import 'package:arstechnica_fschmtz/widgets/newsCardSmall.dart';
import 'package:arstechnica_fschmtz/widgets/newsCardBig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  static const String feedUrl =
      'http://feeds.arstechnica.com/arstechnica/index';
  List<RssItem> articlesList = [];
  bool loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getRssData();
    super.initState();
  }

  Future<void> getRssData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(feedUrl));
    var channel = RssFeed.parse(response.body);
    setState(() {
      articlesList = channel.items.toList();
      loading = false;
    });
    //client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Ars Technica',
            style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
        ListView(physics: AlwaysScrollableScrollPhysics(),
            children: [
                const SizedBox(height: 10),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articlesList.length,
                  itemBuilder: (context, index) {

                    if (index < 3) {
                      return NewsCardBig(
                        feed: Feed(
                          title: articlesList[index].title,
                          link: articlesList[index].link,
                          linkImagem: articlesList[index]
                              .content
                              .images
                              .take(1)
                              .toString()
                              .substring(
                                  1,
                                  articlesList[index]
                                          .content
                                          .images
                                          .take(1)
                                          .toString()
                                          .length -
                                      1),
                          data: articlesList[index].pubDate.toString(),
                        ),
                      );
                    } else {
                      return NewsCardSmall(
                        feed: Feed(
                          title: articlesList[index].title,
                          link: articlesList[index].link,
                          linkImagem: articlesList[index]
                              .content
                              .images
                              .take(1)
                              .toString()
                              .substring(
                                  1,
                                  articlesList[index]
                                          .content
                                          .images
                                          .take(1)
                                          .toString()
                                          .length -
                                      1),
                          data: articlesList[index].pubDate.toString(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.refresh_outlined,
                  size: 24,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  getRssData();
                }),
            IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 24,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Configs(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
      )),
    );
  }
}
