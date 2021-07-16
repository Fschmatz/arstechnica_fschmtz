import 'package:arstechnica_fschmtz/classes/feed.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCardSmall extends StatefulWidget {
  @override
  _NewsCardSmallState createState() => _NewsCardSmallState();

  Feed feed;
  NewsCardSmall({Key key, this.feed}) : super(key: key);
}

class _NewsCardSmallState extends State<NewsCardSmall> {
  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
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
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: widget.feed.linkImagem
                        .contains('http://feeds.feedburner.com/~ff/arstechnica/')
                        ? FadeInImage.assetNetwork(
                        image: "assets/placeholder.jpg",
                        placeholder: "assets/placeholder.jpg",
                        width: 100,
                        height: 75,
                        fit: BoxFit.fill)
                        : FadeInImage.assetNetwork(
                        image: widget.feed.linkImagem,
                        placeholder: "assets/placeholder.jpg",
                        width: 100,
                        height: 75,
                        fit: BoxFit.fill)),
                const SizedBox(width : 10),
                Flexible(
                  child: Text(
                    widget.feed.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text(
                        widget.feed.DataFormatada,
                        style: TextStyle(
                            fontSize: 12.5, color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                  Container(
                    width: 55,
                    child: TextButton(
                      onPressed: () {
                        Share.share(widget.feed.link);
                      },
                      child: Icon(
                        Icons.share_outlined,
                        size: 19,
                        color: Theme.of(context).hintColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).cardTheme.color,
                        onPrimary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
