import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_demo/utils/utils.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;

  File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //CachedNetworkImage(imageUrl: );
            Stack(
              children: [
               image == null ? const CircleAvatar(
                  backgroundColor: Colors.black26,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=2048x2048&w=is&k=20&c=6hQNACQQjktni8CxSS_QSPqJv2tycskYmpFGzxv3FNs=',
                      scale: 1.0),
                  maxRadius: 60,
                ): CircleAvatar(
                 backgroundColor: Colors.black26,
                 backgroundImage: FileImage(image!),
                 maxRadius: 60,
               ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: selectImage,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(20, 20)),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter yor name'),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

}
