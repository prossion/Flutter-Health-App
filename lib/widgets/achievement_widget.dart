import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health/models/achievement_model.dart';
import 'package:flutter_health/widgets/detail_achievement_widget.dart';

class AchievementWidget extends StatelessWidget {
  const AchievementWidget({Key? key, required this.achievement})
      : super(key: key);
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAchievementWidget(
                title: achievement.title,
                description: achievement.description,
                icon: achievement.icon,
              ),
            ),
          );
        },
        child: Card(
          color: achievement.completed == true
              ? Colors.grey.withOpacity(0.4)
              : Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                achievement.icon == null
                    ? CachedNetworkImage(
                        imageUrl: achievement.icon,
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
                  width: 5,
                ),
                Text(
                  achievement.title,
                ),
                const Spacer(),
                achievement.completed == true
                    ? const Icon(Icons.check)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
