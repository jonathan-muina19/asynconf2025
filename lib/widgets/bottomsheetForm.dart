import 'package:asynconf2025/widgets/my_button.dart';
import 'package:asynconf2025/widgets/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'date_field.dart';
import 'dropdownButtonField.dart';

class Bottomsheetform extends StatefulWidget {
  const Bottomsheetform({super.key});

  @override
  State<Bottomsheetform> createState() => _BottomsheetformState();
}

class _BottomsheetformState extends State<Bottomsheetform> {
  final TextEditingController controllerSpeaker = TextEditingController();
  final TextEditingController controllerSubject = TextEditingController();
  String selectedConfType = 'talk';
  DateTime confDateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  // Pour liberer la memoire une fois qu'on recupere les donnes des textformfield
  void dispose() {
    controllerSpeaker.dispose();
    controllerSubject.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  children: [
                    SizedBox(height: 13),
                    Text(
                      'Ajouter une conférence',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              // Pour forcer une espacemment
              Container(margin: EdgeInsets.all(3.0)),
              MyTextfield(
                labelText: 'Nom du speaker',
                hintText: 'ex: Bill Gates',
                controller: controllerSpeaker,
              ),
              MyTextfield(
                labelText: 'Nom du Sujet',
                hintText: '',
                controller: controllerSubject,
              ),
              DateField(
                onDateSelected: (DateTime date) {
                  setState(() {
                    confDateTime = date;
                  });
                },
              ),

              // Pour forcer une espacement
              Container(margin: EdgeInsets.all(3.0)),
              Dropdownbuttonfield(
                selectedConfType: selectedConfType,
                onChanged: (value) {
                  setState(() {
                    selectedConfType = value!;
                  });
                },
              ),
              MyButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final speakerName = controllerSpeaker.text;
                    final subdjetName = controllerSubject.text;
                    final confType = selectedConfType;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Envoi en cours...')),
                    );
                    FocusScope.of(context).requestFocus(FocusNode());

                    // Ajout dans la base des donnees
                    // 1. On recupere notre collection dans Firebase
                    CollectionReference eventsRef = FirebaseFirestore.instance
                        .collection('Events');
                    eventsRef.add({
                      'speaker': speakerName,
                      'subject': subdjetName,
                      'date': Timestamp.fromDate(confDateTime),
                      'type': confType,
                      'avatar': 'musk',
                    });
                    controllerSpeaker.clear();
                    controllerSubject.clear();
                    selectedConfType == '';
                  }
                },
                textTitle: 'Ajouter',
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
