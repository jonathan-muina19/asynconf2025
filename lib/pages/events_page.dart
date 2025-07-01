import 'package:asynconf2025/model/events_model.dart';
import 'package:asynconf2025/widgets/bottomsheetForm.dart';
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
    Future<void> _showDetailsEventDialog(Event eventData) async {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return PopupEvents(eventData: eventData);
        },
      );
    }

    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext contect) {
          return Bottomsheetform();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1877F2),
        title: const Text(
          'Conférence disponible',
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
                    FirebaseFirestore.instance.collection('Events').snapshots(),
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
                  // Si il y a une erreur
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/128/4043/4043346.png',
                          ),
                          Text(
                            'Une erreur est survenue !',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/128/15236/15236412.png',
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Aucun évènement disponible !',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Récupération des données de la base de données
                  List<Event> events = [];

                  snapshot.data!.docs.forEach((data) {
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
                      final type = event.type;
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
                          trailing: Row(
                            mainAxisSize:
                                MainAxisSize.min, // <-- Ceci est essentiel !
                            children: [
                              IconButton(
                                onPressed: () {
                                  // future: voir détails
                                  _showDetailsEventDialog(event);
                                },
                                icon: const Icon(Icons.info_rounded),
                                color: const Color(0xFF1877F2),
                                tooltip: 'Voir détails',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF1877F2),
      ),
    );
  }
}
