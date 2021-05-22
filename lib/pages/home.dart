import 'dart:async';
import 'package:arstechnica_fschmtz/classes/feed.dart';
import 'package:arstechnica_fschmtz/configs/settings.dart';
import 'package:arstechnica_fschmtz/widgets/newsCardSmall.dart';
import 'package:arstechnica_fschmtz/widgets/newsCardBig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String feedUrl =
      'http://feeds.arstechnica.com/arstechnica/index';
  List<RssItem> articlesList = [];
  bool loading = true;

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
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Ars Technica'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context)
                    .textTheme
                    .headline6
                    .color
                    .withOpacity(0.7),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Settings(),
                      fullscreenDialog: true,
                    ));
              }),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: getRssData,
                child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articlesList.length,
                        itemBuilder: (context, index) {
                          if (index < 2) {
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
      ),
    );
  }
}
