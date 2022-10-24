import 'package:flutter/material.dart';

class HealthWidget extends StatelessWidget {
  const HealthWidget({Key? key, required this.steps, required this.calories})
      : super(key: key);
  final int steps;
  final int calories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Total steps for today: ',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$steps',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Total calories for today: ',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$calories',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
