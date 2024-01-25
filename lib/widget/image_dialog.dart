import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, this.tag});

  final Object? tag;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200.w,
        height: 200.h,
        decoration: const BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://www.masflair.com/wp-content/themes/consultix/images/no-image-found-360x250.png'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
