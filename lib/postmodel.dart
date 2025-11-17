class PostModel {
  String profileUrl;
  String name;
  String location;
  String postUrl;
  bool isliked;
  bool isbookmarked;

  PostModel({
    required this.profileUrl,
    required this.name,
    required this.location,
    required this.postUrl,
    required this.isliked,
    required this.isbookmarked,
  });
}
