import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_api/youtube_api.dart';
import '../../modals/globals.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  static String key = "AIzaSyBo9KfkBitYFNhilpU_9KdRXBrGl7mJBhA";
  YoutubeAPI youtube = YoutubeAPI(key, maxResults: 5);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      searchController.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Global.searchList = prefs.getStringList("searchList") ?? [];
    setState(() {});
  }

  bool on = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic),
          ),
        ],
        title: TextField(
          onTap: () {
            setState(() {
              on = true;
            });
          },
          controller: searchController,
          onSubmitted: (val) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            on = false;
            Global.searchList.add(searchController.text);
            Global.searchList = Global.searchList.toSet().toList();

            prefs.setStringList("searchList", Global.searchList);
            callAPI();
            setState(() {});
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search YouTube",
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: (on)
                ? ListView.builder(physics: BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    on = false;
                    searchController.text = Global.searchList[i];
                    callAPI();
                    setState(() {});
                  },
                  leading: const Icon(Icons.history),
                  title: Text(
                    Global.searchList[i],
                    style: const TextStyle(fontSize: 17),
                  ),
                  trailing: const Icon(CupertinoIcons.arrow_up_right),
                );
              },
              itemCount: Global.searchList.length,
            )
                : ListView(physics: BouncingScrollPhysics(),
              children: videoResult.map<Widget>(listItem).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Global.data = video;
        Global.id = video.id.toString();
        setState(() {});
        Navigator.of(context).pushNamed("player_page");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              image: DecorationImage(
                image: NetworkImage("${video.thumbnail.high.url}"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding:
            const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  video.channelTitle,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}