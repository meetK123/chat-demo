import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_demo/screens/auth/auth.dart';
import 'package:chat_demo/screens/auth/login/login_page.dart';
import 'package:chat_demo/screens/chat_screen/chat_screen.dart';
import 'package:chat_demo/widget/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@RoutePage()
//ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Auth auth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: 20,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ),
            );
          },
          child: _buildUserListItem(context, index),
        ),
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(
        children: [
          _buildImageView(context, index),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///user name
                    Expanded(
                      child: Text(
                        'Lorem ipsum ',
                        style: TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    /// times
                    Text(
                      _formatTime(DateTime.now()),
                      style: TextStyle(fontSize: 10.spMin, fontWeight: FontWeight.w200, color: Colors.grey),
                    ),
                  ],
                ),

                /// last message
                Text(
                  'consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa',
                  style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async => await showDialog(
        context: context,
        builder: (context) => ImageDialog(tag: 'Image$index'),
      ),
      child: Hero(
        tag: 'Image$index',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.r),
          child: CachedNetworkImage(
            imageUrl: "https://www.masflair.com/wp-content/themes/consultix/images/no-image-found-360x250.png",
            width: 60.r,
            height: 60.r,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    // Implement time formatting logic here
    return DateFormat('h:mm a').format(time);
  }
}
