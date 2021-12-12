import 'package:flutter/material.dart';
import 'package:flutter_social_ui/models/user_model.dart';
import 'package:flutter_social_ui/widgets/custom_drawer.dart';
import 'package:flutter_social_ui/widgets/page_carousel.dart';
import 'package:flutter_social_ui/widgets/profile_clipper.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();

  PageController _yourFavoritePageController;
  PageController _yourPostPageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yourFavoritePageController=PageController(initialPage: 0, viewportFraction: 0.8);
    _yourPostPageController=PageController(initialPage: 0, viewportFraction: 0.8);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKEy,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                    image: AssetImage(widget.user.backgroundImageUrl),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 15,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                    ),
                    iconSize: 30,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _scaffoldKEy.currentState.openDrawer(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: Image(
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                        image: AssetImage(widget.user.profileImageUrl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Following',
                      style: TextStyle(color: Colors.black54, fontSize: 22),
                    ),
                    Text(
                      widget.user.following.toString(),
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Following',
                      style: TextStyle(color: Colors.black54, fontSize: 22),
                    ),
                    Text(
                      widget.user.followers.toString(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
           PostCarousel(pageController: _yourPostPageController, title:  'Your Posts',posts: widget.user.posts,),
            PostCarousel(pageController: _yourFavoritePageController, title:  'favorites',posts: widget.user.favorites,),

            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
