import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  int audioNo = 0;
  // String audio_url =
  //     'https://docs.google.com/uc?export=download&id=1ZQzfoF0O4TkJCIy1l_bZ2WQH_pzp2J44';

  var my_playlist = [
    {
      "url": "assets/aero.mp3",
      "name": "I don\'t wanna miss a thing",
      "albulm_image": "images/aero.jpg",
      "artist": "Aerosmit",
    },
    {
      "url": "assets/googoo.mp3",
      "name": "Iris",
      "albulm_image": "images/googoodoll.jpg",
      "artist": "Goo Goo Dolls",
    },
    {
      "url": "assets/police.mp3",
      "name": "Every break you take",
      "albulm_image": "images/police.jpg",
      "artist": "The Police",
    },
  ];

  var play_pause = true;
  var result;
  void max_song() {
    if (audioNo == 3) {
      audioNo = 0;
    } else if (audioNo == -1) {
      audioNo = 2;
    }
  }
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;

  // String formatTime(int seconds) {
  //   return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  // }

  @override
  // void initState() {
  //   super.initState();
  //   audioPlayer.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       play_pause = state == PlayerState.PLAYING;
  //     });
  //   });

  //   audioPlayer.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });

  //   audioPlayer.onAudioPositionChanged.listen((newPosition) {
  //     setState(() {
  //       position = newPosition;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image(
                image: AssetImage(my_playlist[audioNo]['albulm_image']!),
                width: 200,
                height: 200,
              ),
            ),
            Text(
              my_playlist[audioNo]['name']!,
              style: const TextStyle(fontSize: 20),
            ),
            Text(my_playlist[audioNo]['artist']!),
            // Text(my_playlist[audioNo]['name']),

            Column(
              children: [
                // Slider(
                //     min: 0.0,
                //     max: duration.inSeconds.toDouble(),
                //     value: position.inSeconds.toDouble(),
                //     onChanged: (value) {
                //       final position = Duration(seconds: value.toInt());
                //       audioPlayer.seek(position);
                //       audioPlayer.resume();
                //     }),
                // Container(
                //   padding: EdgeInsets.all(20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(formatTime(position.inSeconds)),
                //       Text(formatTime((duration - position).inSeconds))
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          audioNo--;
                          setState(() {
                            max_song();
                          });
                          result = await audioPlayer
                              .play(my_playlist[audioNo]['url']!);
                        },
                        icon: const Icon(Icons.skip_previous)),
                    IconButton(
                        onPressed: () async {
                          if (play_pause == true) {
                            result = await audioPlayer
                                .play(my_playlist[audioNo]['url']!);
                          } else {
                            result = await audioPlayer.pause();
                          }

                          setState(() {
                            if (result == 1) {
                              play_pause = !play_pause;
                            }
                          });
                        },
                        icon: play_pause
                            ? const Icon(Icons.play_arrow)
                            : const Icon(Icons.pause)),
                    IconButton(
                        onPressed: () async {
                          audioNo++;
                          setState(() {
                            max_song();
                          });
                          result = await audioPlayer
                              .play(my_playlist[audioNo]['url']!);
                        },
                        icon: const Icon(Icons.skip_next))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
