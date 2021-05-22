import 'package:arstechnica_fschmtz/classes/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCardBig extends StatefulWidget {
  @override
  _NewsCardBigState createState() => _NewsCardBigState();

  Feed feed;

  NewsCardBig({Key key, this.feed}) : super(key: key);
}

class _NewsCardBigState extends State<NewsCardBig> {
  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchBrowser(widget.feed.link);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: widget.feed.linkImagem
                        .contains('http://feeds.feedburner.com/~ff/arstechnica/')
                    ? FadeInImage.assetNetwork(
                        image: "assets/placeholder.jpg",
                        placeholder: "assets/placeholder.jpg",
                        width: 1500,
                        height: 150,
                        fit: BoxFit.fitWidth)
                    : FadeInImage.assetNetwork(
                        image: widget.feed.linkImagem,
                        placeholder: "assets/placeholder.jpg",
                        width: 1500,
                        height: 150,
                        fit: BoxFit.fitWidth)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                  child: Text(
                    widget.feed.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 5,),
                          Text(
                            widget.feed.DataFormatada,
                            style: TextStyle(
                                fontSize: 12.5, color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                      IconButton(
                          color: Theme.of(context).hintColor,
                          icon: Icon(Icons.share_outlined),
                          constraints: BoxConstraints(maxHeight: 30),
                          iconSize: 21,
                          onPressed: () {
                            Share.share(widget.feed.link);
                          }),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
