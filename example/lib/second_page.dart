import 'package:flutter/material.dart';
import 'package:mc_navigator/mc_navigator.dart';

import 'app_routes.dart';

class SecondPage extends StatelessWidget with NavMixin {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
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
  McNavigationRoutes get route => AppRoutes.secondPageRoute;
}
