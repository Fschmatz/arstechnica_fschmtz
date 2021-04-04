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
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                    image: widget.feed.linkImagem,
                    placeholder: "assets/placeholder.jpg",
                    width: 1500,
                    height: 150,
                    fit: BoxFit.fitWidth)),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.feed.title,
                    style: TextStyle(fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.feed.DataFormatada,
                        style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(
                        width: 15,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
