import 'package:asynconf2025/widgets/date_field.dart';
import 'package:asynconf2025/widgets/dropdownButtonField.dart';
import 'package:asynconf2025/widgets/my_button.dart';
import 'package:asynconf2025/widgets/my_textfield.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class FormEvent extends StatefulWidget {


  const FormEvent({super.key});

  @override
  State<FormEvent> createState() => _FormEventState();
}

class _FormEventState extends State<FormEvent> {
  final TextEditingController controllerSpeaker = TextEditingController();
  final TextEditingController controllerSubject = TextEditingController();
  String selectedConfType = 'talk';
  DateTime confDateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  // Pour liberer la memoire une fois qu'on recupere les donnes des textformfield
  void dispose() {
    super.dispose();
    controllerSpeaker.dispose();
    controllerSubject.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF1877F2),
        title: Text('Formulaire', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              MyTextfield(
                  labelText: 'Nom du speaker',
                  hintText: 'ex: Bill Gates',
                  controller: controllerSpeaker
              ),
              SizedBox(height: 20),
              MyTextfield(
                  labelText: 'Nom du Sujet',
                  hintText: '',
                  controller: controllerSubject
              ),
              SizedBox(height: 20),
              DateField(),
              SizedBox(height: 20),
              Dropdownbuttonfield(
                  selectedConfType: selectedConfType,
                  onChanged: (value){
                    setState(() {
                      selectedConfType = value!;
                    });
                  }
              ),
              MyButton(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      final speakerName = controllerSpeaker.text;
                      final subdjetName = controllerSubject.text;
                      final confType = selectedConfType;
                      final dateConf = confDateTime;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Envoi en cours...'))
                      );
                      FocusScope.of(context).requestFocus(FocusNode());
                      print('Ajout du speaker $speakerName ');
                      print('Sujet : $subdjetName');
                      print('Type de conference :$confType');
                      print('Date du conference : $confDateTime');
                    }
                  },
                  textTitle: 'Envoyer',
                  icon: Icon(Icons.send)
              )
            ],
          ),
        ),
      ),
    );
  }
}
