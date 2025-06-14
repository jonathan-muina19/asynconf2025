import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1877F2),
        title: Text('Planing du salon', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Prochainnement disponble')
          ],
        ),
      ),
    );
  }
}
