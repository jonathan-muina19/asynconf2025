import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  final events = [
    {
      'speaker' : 'Elon Musk',
      'subject' : 'Spacex & Tesla',
      'avatar'  : 'musk',
      'date'    : '20 juin 2025'
    },
    {
      'speaker' : 'Sunder Pichai',
      'subject' : 'Co google Founder',
      'avatar'  : 'googleco',
      'date'    : '27 juin 2025'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF1877F2),
        title: Text('Planing du salon', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        ),
        
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index){
          final event = events[index];
          final avatar = event['avatar'];
          final speaker = event['speaker'];
          final subject = event['subject'];
          final date = event['date'];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/$avatar.jpg'),
              ),
              title: Text('$speaker', style: TextStyle(
                fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text('$subject , $date'),
              trailing: IconButton(
                  onPressed: (){
                  },
                  icon: Icon(Icons.info_rounded)
              ),

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.push('/formulaire');
        },
        backgroundColor: Color(0xFF1877F2),
        child: Icon(Icons.add, color: Colors.white,)
      ),
    );
  }
}
