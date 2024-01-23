import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';

class ImageHandlerWidget extends StatelessWidget {

  final String? path;
  final double width;

  const ImageHandlerWidget({
    super.key,
    required this.path, required this.width
  });

  @override
  Widget build(BuildContext context) {
    if ((path ?? "").isEmpty) {
      return Container(
        width: width,
        child: Icon(Icons.error),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: '$BASE_IMAGE_URL$path',
        width: width,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
  }
}