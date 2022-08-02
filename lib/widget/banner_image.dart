import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  const BannerImage(this.url, {Key? key, this.fit = BoxFit.fill})
      : super(key: key);

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      placeholder: (_, url) =>
          const Center(child: CupertinoActivityIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
