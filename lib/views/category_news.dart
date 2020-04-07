import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/views/article_view.dart';

class CategoryView extends StatefulWidget {
  final String category;
  CategoryView({this.category});
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> article = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    article = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

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
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ///Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: article.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: article[index].urlToImage,
                        title: article[index].title,
                        desc: article[index].description,
                        url: article[index].url,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              BlogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)
            ),
            SizedBox(height: 8),
            Text(title, style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8),
            Text(desc, style: TextStyle(
                color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}