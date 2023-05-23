class Song {
  late String song_url;
  String? artwork;
  late String artist;
  late String name;

  Song(
      {required this.song_url,
      this.artwork,
      required this.artist,
      required this.name});
}
