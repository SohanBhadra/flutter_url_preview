library flutterurlpreview;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class UrlPreviewTextField extends StatefulWidget {
  final Widget child;
  final TextEditingController controller;

  final Color backgroundColor;
  final Widget leading;
  final Widget trailing;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final int maxLines;
  final InputDecoration decoration;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final double imageHeight;
  final double imageWidth;
  final EdgeInsetsGeometry textBoxOuterPadding;

  UrlPreviewTextField({
    @required this.child,
    @required this.controller,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.textCapitalization,
    this.keyboardType,
    this.maxLines,
    this.decoration,
    this.titleStyle,
    this.descriptionStyle,
    this.imageHeight,
    this.imageWidth,
    this.textBoxOuterPadding,
  });

  @override
  _UrlPreviewTextFieldState createState() => _UrlPreviewTextFieldState();
}

class _UrlPreviewTextFieldState extends State<UrlPreviewTextField> {
  LinkData data;

  void getLinkData(String url) async {
    final result = await checkAndGetLinkData(url);
    setState(() => data = result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: widget.child),
        Container(
          color: widget.backgroundColor ?? Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Visibility(
                visible: data != null,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            if (data != null)
                              if (data.image != null)
                                if (data.image.isNotEmpty)
                                  Image.network(
                                    data.image,
                                    fit: BoxFit.cover,
                                    height: widget.imageHeight ?? 50,
                                    width: widget.imageWidth ?? 50,
                                  ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (data != null)
                                      if (data.title != null)
                                        if (data.title.isNotEmpty)
                                          Text(
                                            data.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: widget.titleStyle,
                                          ),
                                    if (data != null)
                                      if (data.description != null)
                                        if (data.description.isNotEmpty)
                                          Text(
                                            data.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: widget.descriptionStyle,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.black87,
                              iconSize: 25.0,
                              onPressed: () => setState(() => data = null),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: widget.textBoxOuterPadding ??
                    EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    widget.leading ?? SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        textCapitalization: widget.textCapitalization ??
                            TextCapitalization.sentences,
                        onChanged: (value) => getLinkData(value),
                        keyboardType:
                            widget.keyboardType ?? TextInputType.multiline,
                        maxLines: widget.maxLines ?? null,
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        decoration: widget.decoration,
                      ),
                    ),
                    widget.trailing ?? SizedBox(width: 8.0),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class LinkData {
  String title;
  String description;
  String url;
  String image;
  String type;
  String siteName;

  LinkData(
      {this.title,
      this.description,
      this.url,
      this.image,
      this.type,
      this.siteName});

  LinkData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    image = json['image'];
    type = json['type'];
    siteName = json['site_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['image'] = this.image;
    data['type'] = this.type;
    data['site_name'] = this.siteName;
    return data;
  }
}

Future<LinkData> checkAndGetLinkData(String str) async {
  RegExp exp =
      new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  final b = exp.hasMatch(str);
  if (b) {
    final match = exp.firstMatch(str);
    final url = str.substring(match.start, match.end);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = getOpenGraphDataFromResponse(response);
      return LinkData.fromJson(result);
    }
  }
  return null;
}

Map<String, dynamic> getOpenGraphDataFromResponse(http.Response response) {
  var requiredAttributes = ['title', 'image'];
  Map<String, dynamic> data = new Map<String, dynamic>();
  var document = parser.parse(utf8.decode(response.bodyBytes));
  var openGraphMetaTags = document.head.querySelectorAll("[property*='og:']");
  openGraphMetaTags.forEach((element) {
    var ogTagTitle = element.attributes['property'].split("og:")[1];
    var ogTagValue = element.attributes['content'];
    if ((ogTagValue != null && ogTagValue != "") ||
        requiredAttributes.contains(ogTagTitle)) {
      if (ogTagValue == null || ogTagValue.length == 0) {
        ogTagValue = _scrapeAlternateToEmptyValue(ogTagTitle, document);
      }
      data[ogTagTitle] = ogTagValue;
    }
  });
  return data;
}

String _scrapeAlternateToEmptyValue(String tagTitle, dom.Document document) {
  if (tagTitle == "title") {
    return document.head.getElementsByTagName("title")[0].text;
  }
  if (tagTitle == "image") {
    var images = document.body.getElementsByTagName("img");
    if (images.length > 0) {
      return images[0].attributes["src"];
    }
    return "";
  }
  return "";
}
