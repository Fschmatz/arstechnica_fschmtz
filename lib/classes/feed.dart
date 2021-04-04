import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';

class Feed {

  final String title;
  final String link;
  final String linkImagem;
  final String data;

  Feed({this.title,this.link,this.linkImagem,this.data});

  get DataFormatada{
    return Jiffy(this.data).format("dd/MM/yyyy");
  }
}