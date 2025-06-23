import 'package:asynconf2025/pages/events_page.dart';
import 'package:asynconf2025/pages/form_event.dart';
import 'package:asynconf2025/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    // ShellRoute permet d’ajouter un Scaffold commun à plusieurs pages.
    // Parfait pour mettre une AppBar et un BottomNavigationBar partagés.
    //N.B : ShellRoute c'est  quand on veut utiliser go_router pour la navigation
    ShellRoute(
      builder: (context, state, child) {
        // Détecter la route active
        final location = state.uri.path; // Cela te donne le chemin actuel de la route
        int currentIndex = 0;

        if (location == '/events_page') {
          currentIndex = 1;
        } else if (location == '/formulaire') {
          currentIndex = 2;
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 0) {
                context.go('/');
              } else if (index == 1) {
                context.go('/events_page');
              } else if (index == 2) {
                context.go('/formulaire');
              }
            },
            selectedItemColor: const Color(0xFF1877F2),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Événements',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Formulaire',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/events_page',
          builder: (context, state) => const EventsPage(),
        ),
        GoRoute(
          path: '/formulaire',
          builder: (context, state) => const FormEvent(),
        ),
      ],
    ),

    // Autres routes (ex: formulaire) qui ne doivent pas avoir le BottomNav
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
    );
  }
}
