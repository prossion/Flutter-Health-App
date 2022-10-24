import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailAchievementWidget extends StatelessWidget {
  const DetailAchievementWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.icon})
      : super(key: key);
  final String title;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? CachedNetworkImage(
                    imageUrl: icon,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      height: 50,
                      width: 50,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.blueGrey.shade200,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.icecream_outlined),
                        ),
                      ),
                    ),
                  )
                : const Icon(Icons.card_giftcard_sharp),
            const SizedBox(
              height: 10,
            ),
            Text(title),
            const SizedBox(
              height: 10,
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
