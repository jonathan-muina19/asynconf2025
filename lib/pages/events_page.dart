import 'package:asynconf2025/model/events_model.dart';
import 'package:asynconf2025/widgets/my_button.dart';
import 'package:asynconf2025/widgets/popup_events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
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
    // Cette methode permet d'afficher la popup
    Future<void> _showDetailsEventDialog(Event eventData) async{
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context){
            return PopupEvents(eventData: eventData );
          }
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1877F2),
        title: const Text(
          'Planing du salon',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF1877F2)),
              )
              : StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection('Events')
                        .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1877F2),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucune conférence"));
                  }

                  List<Event> events = [];
                  snapshot.data!.docs.forEach((data){
                    final event = Event.fromData(data.data());
                    events.add(event);
                  });

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      final avatar = event.avatar.toString().toLowerCase();
                      final speaker = event.speaker;
                      final subject = event.subject;
                      final Timestamp timestamp = event.timestamp;
                      final String date = DateFormat.yMd().add_jm().format(
                        timestamp.toDate(),
                      );
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/images/$avatar.jpg',
                            ),
                          ),
                          title: Text(
                            '$speaker',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('$subject\n$date'),
                          trailing: IconButton(
                            onPressed: () {
                              // future: voir détails
                              _showDetailsEventDialog(event);
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
