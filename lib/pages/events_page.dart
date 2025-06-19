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
      body: StreamBuilder(
        // On recupere les donnees de la collection Events
        // On peut aussi faire de filtres
          stream: FirebaseFirestore.instance.collection('Events').orderBy('date').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(!snapshot.hasData){
              return Text("Aucune conference");
            }
            List<dynamic> events = [];
            snapshot.data!.docs.forEach((element){
              events.add(element);
            });
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index){
                final event = events[index];
                final avatar = event['avatar'].toString().toLowerCase();
                final speaker = event['speaker'];
                final subject = event['subject'];
                final Timestamp timestamp = event['date'];
                final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());

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
                    subtitle: Text('$subject , \n$date'),
                    trailing: IconButton(
                        onPressed: (){
                        },
                        icon: Icon(Icons.info_rounded)
                    ),

                  ),
                );
              },
            );

          }
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
