import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mc_navigator/mc_navigator.dart';

import 'app_routes.dart';
import 'second_page.dart';

void main() {
  NavigatorInitializer.setMaterial();
  McNavigationHistory().historyChangeStream().listen((McHistoryChange change) {
    change.action;
    String? newRouteName = change.newRoute?.settings.name;
    String? oldRouteName = change.oldRoute?.settings.name;
    if (kDebugMode) {
      print('⚠️ ⚠️  $oldRouteName ==> $newRouteName');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const MyHomePage homePage = MyHomePage(title: 'Flutter Demo Home Page');
    // Todo: Uncommit next line when using named route type. [NavigatorInitializer.setNamedRoute()]
    // Map<String, WidgetBuilder> routeList = McNavigationRoutes.buildRouteList([
    //   homePage,
    //   SecondPage(),
    //   ThirdPage(),
    // ]);
    return MaterialApp(
      title: 'Flutter Demo',
      // routes: routeList,
      navigatorObservers: <NavigatorObserver>[
        McNavigationHistory().observer,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: homePage,
    );
  }
}

class MyHomePage extends StatefulWidget with NavMixin {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  @override
  Widget get getWidget => this;

  @override
  McNavigationRoutes get route => AppRoutes.homeRoute;
}

class _MyHomePageState extends State<MyHomePage> {
  static const int _maxCount = 12;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    if (_counter >= _maxCount) {
      _handleMaxCountValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              const SecondPage().navBy(context).push();
            },
            icon: const Icon(Icons.arrow_circle_right_outlined),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleMaxCountValue() {
    showDialog<void>(
      context: context,
      barrierLabel: AppRoutes.maxCounterRoute.title,
      routeSettings: AppRoutes.maxCounterRoute.routeSettings,
      barrierDismissible: AppRoutes.maxCounterRoute.isDismissible,
      builder: (BuildContext dialogContext) {
        return _MyAlertDialog(onTap: () {
          _counter = 0;
          Navigator.of(dialogContext).pop();
          setState(() {});
        });
      },
    );
  }
}

class _MyAlertDialog extends AlertDialog {
  @override
  final List<Widget> actions = <Widget>[];

  _MyAlertDialog({
    super.title = const Text('Warning!'),
    super.content = const Text('You got the maximum count value'),
    required VoidCallback onTap,
  }) {
    actions.add(TextButton(
      onPressed: onTap,
      child: const Text('Reset'),
    ));
  }
}
