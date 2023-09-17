import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../modals/globals.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: Global.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        enableCaption: true,
        forceHD: true,
        useHybridComposition: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    YoutubePlayer(
      controller: youtubePlayerController,
      showVideoProgressIndicator: true,
      onReady: () {
        youtubePlayerController.addListener(() {});
      },
    );
    return Scaffold(
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: youtubePlayerController),
          builder: (context, player) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  player,
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    Global.data!.title,
                    style: const TextStyle(fontSize: 17),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buttons(Icons.thumb_up_outlined, "Like"),
                        buttons(Icons.thumb_down_alt_outlined, "Dislike"),
                        buttons(Icons.share_outlined, "Share"),
                        buttons(Icons.slow_motion_video, "Create"),
                        buttons(Icons.download_outlined, "Download"),
                        buttons(Icons.add_box_outlined, "Save"),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        Global.data!.channelTitle,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Subscribe",
                          style: TextStyle(color: Colors.red,fontSize: 18),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),

                  Text(
                    "${Global.data!.description}",
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            );
          }),
    );
  }

  buttons(icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          IconButton(onPressed: () {}, icon: Icon(icon)),
          Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
