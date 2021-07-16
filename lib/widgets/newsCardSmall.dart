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
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.feed.title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                widget.feed.DataFormatada,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5, color: Theme.of(context).hintColor),
              ),
            ),
            trailing: Container(
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
          ),
        ],
      ),
    );
  }
}
