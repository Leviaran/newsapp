import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timeago/timeago.dart';
import 'package:intl/intl.dart';
import 'news_drawer.dart';

class NewsHomePage extends StatefulWidget {

  @override
  _NewsHomePageState createState() => new _NewsHomePageState();

  final String title;
  NewsHomePage({Key key, this.title}) : super(key : key);

}

class _NewsHomePageState extends State<NewsHomePage> {

  bool _isRequestSent = false;
  List<News> newsList = [];

  @override
  Widget build(BuildContext context){

    if(!_isRequestSent){
      _sendRequest();
    }

    return new Scaffold(
      drawer: new NewsDrawer(),
      appBar: new AppBar(
        title: new Text(
          widget.title
        ),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: !_isRequestSent ? new CircularProgressIndicator() : new Container(
          child: new ListView.builder(
            itemCount: newsList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index){
              return _getPostWidget(index);
            },
          ),
        )
      ),
    );
  }

  void _sendRequest() async {
    String url = "https://newsapi.org/v2/top-headlines?"
    "country=id&apiKey=333ae9c349214b93a50d506f48f1c7bf";
    http.Response response = await http.get(url);
    Map decode = json.decode(response.body);
    List results = decode['articles'];

    for(var jsonObject in results){
      var post = News.getPostFromJsonNews(jsonObject);
      newsList.add(post);
      print(post);
    }

    setState(() => _isRequestSent = true);

  }

  Widget _getPostWidget(int index){  
      
    var news = newsList[index];
    return new GestureDetector(
      onTap: (){
        opendetailNews(news);
      },
      child: new Container(        
        height: 100.0,
        child: new Card(
          elevation: 2.0,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 130.0,
                height: 100.0,
                child: new FadeInImage.assetNetwork(                  
                  placeholder: new AssetImage('lib/noimage.png').keyName,
                  image: news.urlToImage !=null ? news.urlToImage : 'lib/noimage.png',
                  fit: BoxFit.cover,
                  imageScale: 0.5,
                                    
                ),
              ),
              new Expanded(                
                child: new Container(
                  padding: EdgeInsets.only(top: 15.0,right: 7.0, left: 7.0),                                                                        
                  child: new Column(                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(                      
                        news.title,                      
                        style: new TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,                        
                        ),
                    new Divider(),
                    new Row(                                                                                                              
                      children: <Widget>[                        
                        new Expanded(
                          child: new Text(                  
                                 news.name,
                                 style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black45),
                                 textAlign: TextAlign.left,
                        ),
                        ),
                        new Icon(
                          Icons.access_time,
                          size: 10.0,                                                                              
                        ),
                        new Text(
                          ' ${lastAgo(news.publishedAt)}',
                          style: new TextStyle(fontSize: 10.0),                          
                        )
                      ],
                    ),                    
                  ],
                ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  opendetailNews(News news){
    print("hallo object");
  }

  String lastAgo(int millis){  
    TimeAgo ta = new TimeAgo();
    ta.locale = 'id';
    var timestamp = new DateTime.fromMillisecondsSinceEpoch(millis);
    final last = new DateTime.now().difference(timestamp);
    final ago = new DateTime.now().subtract(last);
    print(ta.toString());
    print(ta.format(ago));
    return ta.format(ago);
  }

}

class Source{
  String name;
}

class News {
  String author;
  String title;
  String description;
  String urlToImage;
  int publishedAt;
  String name;

  News(this.author, this.title, this.description, this.urlToImage, this.publishedAt, this.name);

  static News getPostFromJsonNews(dynamic jsonObject){
    String author = jsonObject['author'];
    String title = jsonObject['title'];
    String description = jsonObject['description'];
    String urlToImage = jsonObject['urlToImage'];
    Map<String, dynamic> id = jsonObject['source'];
    
    int timeStamp = DateTime.parse(jsonObject['publishedAt']).millisecondsSinceEpoch;

    return new News(author, title, description, urlToImage, timeStamp, id['name']);


  }

  @override
  String toString(){
    return "author = $author; title = $title; description = $description; urlToImage = $urlToImage; timeStamp = $publishedAt"
    "name = $name";
  }

}