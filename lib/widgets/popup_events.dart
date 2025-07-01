import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/events_model.dart';

class PopupEvents extends StatelessWidget {
  final Event eventData;
  const PopupEvents({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade50,
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/${eventData.avatar}.jpg',
                ),
              ),
              SizedBox(height: 20),
              Text('Titre : ${eventData.subject}'),
              Text('Speaker : ${eventData.speaker}'),
              Text(
                'Date : ${DateFormat.yMd().add_jm().format(eventData.timestamp.toDate())}',
              ),
              Text('Type de la conf : ${eventData.type}'),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Text('Ajouter au calendrier'),
            icon: Icon(Icons.calendar_month),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1877F2), // Fond bleu
              foregroundColor: Colors.white, // Texte et icône en blanc
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Bords arrondis
              ),
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }
}
