import 'package:flutter/material.dart';
import 'package:instagram_clone/search_page.dart';
import 'postmodel.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InstagramHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InstagramHomePage extends StatelessWidget {
  const InstagramHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InstagramHome();
  }
}

class InstagramHome extends StatefulWidget {
  const InstagramHome({super.key});

  @override
  State<InstagramHome> createState() => _InstagramHomeState();
}

class _InstagramHomeState extends State<InstagramHome> {
  addbottomsheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create New Post",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Profile URL"),
                TextField(
                  controller: profileUrlController,
                  decoration: InputDecoration(
                    hintText: "Enter profile image URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Name"),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Location"),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "Enter location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Post URL"),
                TextField(
                  controller: postUrlController,
                  decoration: InputDecoration(
                    hintText: "Enter post image URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          locationController.text.isNotEmpty &&
                          postUrlController.text.isNotEmpty) {
                        setState(() {
                          posts.add(
                            PostModel(
                              profileUrl: profileUrlController.text,
                              name: nameController.text,
                              location: locationController.text,
                              postUrl: postUrlController.text,
                              isliked: false,
                              isbookmarked: false,
                            ),
                          );
                        });
                        profileUrlController.clear();
                        nameController.clear();
                        locationController.clear();
                        postUrlController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Create Post",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _currentIndex = 0;
  List<PostModel> posts = [];

  TextEditingController profileUrlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController postUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 34,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 1,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          Icon(Icons.favorite_border, color: Colors.white),
          SizedBox(width: 20),
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.mark_chat_unread_outlined),
                onPressed: () {
                  // Open the right-side drawer
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
          // Icon(Icons.mark_chat_unread_outlined, color: Colors.white),
        ],
      ),
      body:
          posts.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library_sharp,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No posts yet',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    // Text(
                    //   'Tap the + button to create your first post',
                    //   style: TextStyle(fontSize: 16, color: Colors.grey),
                    // ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    post: post,
                    onLikeToggle: () {
                      setState(() {
                        post.isliked = !post.isliked;
                      });
                    },
                    onBookmarkToggle: () {
                      setState(() {
                        post.isbookmarked = !post.isbookmarked;
                      });
                    },
                  );
                },
              ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},

      //   backgroundColor: const Color.fromARGB(255, 0, 5, 8),
      //   child: Icon(Icons.add, color: Colors.white),
      // ),

      //Bottom navigationbar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        onTap: (index) {
          // currentIndex = index;
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              icon: Icon(Icons.search),
            ),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                postUrlController.clear();
                nameController.clear();
                profileUrlController.clear();
                locationController.clear();
                addbottomsheet();
              },
              icon: Icon(Icons.add_box_outlined),
            ),

            label: "post",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ondemand_video_rounded),
            ),
            label: "reels",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person_outline),
            ),
            label: "profile",
          ),
        ],
      ),
      // endDrawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(child: ListTile(title: Icon(Icons.settings))),
      //     ],
      //   ),
      // ),
    );
  }
}

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLikeToggle;
  final VoidCallback onBookmarkToggle;

  const PostCard({
    super.key,
    required this.post,
    required this.onLikeToggle,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with profile and username
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  backgroundImage:
                      post.profileUrl.isNotEmpty
                          ? NetworkImage(post.profileUrl)
                          : null,
                  child:
                      post.profileUrl.isEmpty
                          ? Text(
                            post.name[0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          )
                          : null,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
          // Post image
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: Image.network(
          //     post.postUrl,
          //     fit: BoxFit.cover,
          //     loadingBuilder: (context, child, loadingProgress) {
          //       if (loadingProgress == null) return child;
          //       return Center(child: CircularProgressIndicator());
          //     },
          //     errorBuilder: (context, error, stackTrace) {
          //       return Container(
          //         color: Colors.grey[200],
          //         child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
          //       );
          //     },
          //   ),
          // ),
          // Action buttons
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Image.network(post.postUrl, fit: BoxFit.cover),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isliked ? Icons.favorite : Icons.favorite_border,
                    color: post.isliked ? Colors.red : Colors.black,
                  ),
                  onPressed: onLikeToggle,
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline),
                  onPressed: () {},
                ),
                IconButton(icon: Icon(Icons.send), onPressed: () {}),
                Spacer(),
                IconButton(
                  icon: Icon(
                    post.isbookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: onBookmarkToggle,
                ),
              ],
            ),
          ),
          // Likes count
          Padding(
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Liked by ${post.isliked ? 'you and ' : ''}others',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
