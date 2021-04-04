import 'package:arstechnica_fschmtz/classes/feed.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();

  Feed feed;

  NewsCard({Key key, this.feed}) : super(key: key);
}

class _NewsCardState extends State<NewsCard> {
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
          _launchBrowser(widget.feed.link.toString());
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
                      child: FadeInImage.assetNetwork(
                          image: widget.feed.linkImagem,
                          placeholder: "assets/placeholder.jpg",
                          width: 120,
                          height: 80,
                          fit: BoxFit.fill)),
                  const SizedBox(width: 10,),
                  Flexible(
                    child: Text(
                      widget.feed.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15,),
                  IconButton(
                      icon: Icon(Icons.share_outlined),
                      constraints: BoxConstraints(),
                      iconSize: 22,
                      onPressed: () {
                        Share.share(widget.feed.link);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
