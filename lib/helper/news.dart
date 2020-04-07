import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7ea9d4ace5c9403eb3f6907e1ed64cfa";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
           // publishedAt: element["publishedAt"],
            content: element["content"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7ea9d4ace5c9403eb3f6907e1ed64cfa";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              // publishedAt: element["publishedAt"],
              content: element["content"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}