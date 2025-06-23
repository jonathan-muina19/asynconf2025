import 'package:flutter/material.dart';

class PopupEvents extends StatelessWidget {
  const PopupEvents({super.key});

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
                backgroundImage: AssetImage('assets/images/musk.jpg'),
              ),
              SizedBox(height: 20),
              Text('Titre : Sujet de conf'),
              Text('Spesker : Elon Musk'),
              Text('Date de la conf : 25 juin 2025 a 12h'),
            ],
          ),
        ),
      ),
      actions: <Widget> [
        Center(
          child: ElevatedButton.icon(
            onPressed: (){
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
        )
      ],
    );;
  }
}
