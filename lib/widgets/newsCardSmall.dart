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
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: Colors.grey[700].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onTap: () {
          _launchBrowser(widget.feed.link);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.feed.DataFormatada,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).hintColor),
                    ),
                    IconButton(
                        color: Theme.of(context).hintColor,
                        icon: Icon(Icons.share_outlined),
                        constraints: BoxConstraints(),
                        iconSize: 22,
                        onPressed: () {
                          Share.share(widget.feed.link);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
