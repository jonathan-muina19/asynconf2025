import 'package:asynconf2025/pages/events_page.dart';
import 'package:asynconf2025/pages/form_event.dart';
import 'package:asynconf2025/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage()
      ),
      GoRoute(
          path: '/events_page',
          builder: (context, state) => EventsPage()
      ),
      GoRoute(
        path: '/formulaire',
        pageBuilder: (context, state){
          return MaterialPage(
            fullscreenDialog: true,
              child: FormEvent()
          );
        }
      )
    ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          )
        )
      ),
    );
  }
}
