import 'package:arstechnica_fschmtz/util/nameChangelog.dart';
import 'package:flutter/material.dart';

class Changelog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Color themeColorApp = Theme.of(context).accentColor;

    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Current Version".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: themeColorApp))),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              NameChangelog.changelogCurrent,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Previous Versions".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              NameChangelog.changelogsOld,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ]));
  }
}
