import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget {
  static Widget returnPrimaryCachedNetworkImage(String url, BuildContext context) {
    return CachedNetworkImage(
      width: MediaQuery.of(context).size.width,
      height: 200,
      fit: BoxFit.fill,
       imageUrl: url,
       progressIndicatorBuilder: (context, url, downloadProgress) => 
          Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
       errorWidget: (context, url, error) => 
        const Center(
          child: IconsUtils.errorIcon
        ),
    );
  }    
}