import 'package:flutter/material.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/models/user_model.dart';
import 'package:flutter_social_ui/widgets/custom_drawer.dart';
import 'package:flutter_social_ui/widgets/page_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _pageController=PageController(initialPage: 0,viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'FRENZY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 34,
            letterSpacing: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          indicatorWeight: 4,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 18),
          controller: tabController,
          tabs: [
            Tab(
              text: 'Trending',
            ),
            Tab(
              text: 'Latest',
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          FollowingUsers(),
          PostCarousel(pageController: _pageController, title: 'Posts', posts: posts),
        ],
      ),
    );
  }
}

class FollowingUsers extends StatelessWidget {
  const FollowingUsers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 20, 20, 10),
          child: Text(
            'Following',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 80,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                User user = users[index];
                return GestureDetector(
                  onTap: (){
                    //go to users
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2.0,color: Theme.of(context).primaryColor),
                        //borderRadius: BorderRadius.circular(50),
                        boxShadow: [BoxShadow(

                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0
                        )]
                      ),
                      child: ClipOval(
                        child: Image(
                    image: AssetImage(user.profileImageUrl),
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                      )),
                );
              },
              itemCount: users.length),

        ),
      ],
    );
  }
}
