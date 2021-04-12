import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = RootRouterDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        RootLocation(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

class RootLocation extends BeamLocation {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext? context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        child: Beamer(
          key: _beamerKey,
          routerDelegate: BeamerRouterDelegate(
            locationBuilder: BeamerLocationBuilder(
              beamLocations: [
                HomeLocation(),
                SettingsLocation(),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}

class HomeLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => [
        '/',
      ];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        child: HomeScreen(),
      ),
    ];
  }
}

class SettingsLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => [
        '/settings',
      ];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('settings'),
        child: SettingsScreen(),
      ),
    ];
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.beamToNamed('/settings');
        },
        child: Text('settings'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.beamBack();
        },
        child: Text('beam back'),
      ),
    );
  }
}
