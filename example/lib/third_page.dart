import 'package:flutter/material.dart';
import 'package:mc_navigator/mc_navigator.dart';

import 'app_routes.dart';

class ThirdPage extends StatelessWidget with NavMixin {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('3rd Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello World!',
            ),
            const SizedBox(height: 100),
            TextButton(
              onPressed: () {
                navBy(context).pop();
              },
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Map<String, String?> get args => {};

  @override
  Widget get getWidget => this;

  @override
  McNavigationRoutes get route => AppRoutes.thirdPageRoute;
}
