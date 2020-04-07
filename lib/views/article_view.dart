import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String BlogUrl;
  ArticleView({this.BlogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text("Flutter"),
            Text("News",style: TextStyle(
            color: Colors.blue
         ),)
        ],
       ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)
              ),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
      ),
       body: Container(
         height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
          initialUrl: widget.BlogUrl,
          onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);
          }),
         ),
       ),
    );
  }
}
