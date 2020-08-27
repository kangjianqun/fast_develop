import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  BannerImage(this.url, {this.fit: BoxFit.fill});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      placeholder: (_, url) => Center(child: CupertinoActivityIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
