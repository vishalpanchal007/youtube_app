import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../modals/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String APIkey = "AIzaSyBo9KfkBitYFNhilpU_9KdRXBrGl7mJBhA";

  YoutubeAPI youtubeAPI = YoutubeAPI(APIkey, maxResults: 100);
  List<YouTubeVideo> youtubevideo = [];

  Future<void> callAPI() async {
    String query = "Movie trailer";
    youtubevideo = await youtubeAPI.search(query,
        order: "relevance", videoDuration: "any");
    youtubevideo = await youtubeAPI.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    callAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image(
              image: AssetImage("assets/youtube.png"),
              height: size.height * 0.06,
              width: size.width * 0.1,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              "Youtube",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.connected_tv),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "searchPage");
            },
            icon: Icon(Icons.search),
          ),
          CircleAvatar(
            radius: 19,
            child: Text("H",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
          SizedBox(
            width: size.width * 0.02,
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: youtubevideo.map(listItem).toList(),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Global.data=video;
        Global.id=video.id.toString();
        Navigator.pushNamed(context, "openPage");
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(video.thumbnail.high.url ?? ""),
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  video.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  video.channelTitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}