import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  const DateField({super.key});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime confDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DateTimeFormField(
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0), // Exemple : Couleur verte et plus épaisse
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: 'Choisir une date',
            labelStyle: TextStyle(
              color: Color(0xFF616161)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15)
              ),
            )
        ),
        validator: (value){
          if(value == null || value == ''){
            return 'Ce champ est obligatoire';
          }
          return null;
        },
        firstDate: DateTime.now().add(const Duration(days: 10)),
        lastDate: DateTime.now().add(const Duration(days: 40)),
        initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
        onChanged: (DateTime? value) {
          confDateTime = value!;
        },
      ),
    );
  }
}
