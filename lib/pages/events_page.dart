import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Délai simulé de 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1877F2),
        title: const Text(
          'Planing du salon',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1877F2),
        ),
      )
          : StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Events')
            .orderBy('date')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1877F2),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Aucune conférence"),
            );
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final avatar =
              event['avatar'].toString().toLowerCase();
              final speaker = event['speaker'];
              final subject = event['subject'];
              final Timestamp timestamp = event['date'];
              final String date = DateFormat.yMd()
                  .add_jm()
                  .format(timestamp.toDate());

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    AssetImage('assets/images/$avatar.jpg'),
                  ),
                  title: Text(
                    '$speaker',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('$subject\n$date'),
                  trailing: IconButton(
                    onPressed: () {
                      // future: voir détails
                    },
                    icon: const Icon(Icons.info_rounded),
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}
