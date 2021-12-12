import 'package:flutter/material.dart';
import 'package:flutter_social_ui/models/post_model.dart';

class PostCarousel extends StatelessWidget {
  _buildPost(BuildContext context, int index) {
    Post post = posts[index];
    return AnimatedBuilder(
      animation: pageController,
       builder: (BuildContext context, Widget widget){
        double value=1;
        if(pageController.position.haveDimensions){
          value= pageController.page - index;
          value=( 1 - value.abs()*0.25).clamp(0.0, 1.0);//distance between post and next index?

        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value)*400,
            child: widget,
          ),
        );
       },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2), color: Colors.black26, blurRadius: 6.0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 400,
                width: 300,
                fit: BoxFit.fill,
                image: AssetImage('${post.imageUrl}'),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    post.location,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(post.likes.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(post.comments.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.all(12),
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
            ),
          )
        ],
      ),
    );
  }

  //pageController: _pageController, title: 'Posts', posts: posts
  final PageController pageController;
  final String title;
  final List<Post> posts;

  PostCarousel({this.pageController, this.posts, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 20, 20, 10),
          child: Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          height: 400,
          child: PageView.builder(
              controller: pageController,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPost(context, index);
              }),
        )
      ],
    );
  }
}
