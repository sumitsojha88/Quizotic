import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:provider/provider.dart';
import 'package:quizotic/screens/home.dart';
import 'package:quizotic/styles.dart';
import 'data/app_state.dart';
import 'data/preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Orientation of app is fixed from below.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Restorations are used for state management in the app.
  runApp(
    RootRestorationScope(
      restorationId: 'root',
      child: QuizoticApp(),
    ),
  );
}

class QuizoticApp extends StatefulWidget {
  @override
  _QuizoticAppState createState() => _QuizoticAppState();
}

class _QuizoticAppState extends State<QuizoticApp> with RestorationMixin {
  final _RestorableAppState _appState = _RestorableAppState();

  @override
  String get restorationId => 'wrapper';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_appState, 'state');
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _appState.value,
        ),
        ChangeNotifierProvider(
          create: (_) => Preferences()..load(),
        ),
      ],
      child: CupertinoApp(
        theme: Styles.veggieThemeData,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(restorationId: 'home'),
        // restorationScopeId: 'app',
      ),
    );
  }
}

class _RestorableAppState extends RestorableListenable<AppState> {
  @override
  AppState createDefaultValue() {
    return AppState();
  }

  @override
  AppState fromPrimitives(Object data) {
    final appState = AppState();
    final favorites = (data as List<dynamic>).cast<int>();
    for (var id in favorites) {
      appState.setFavorite(id, true);
    }
    return appState;
  }

  @override
  Object toPrimitives() {
    return value.favoriteVeggies.map((veggie) => veggie.id).toList();
  }
}
