import 'package:flutter/material.dart';

class Dropdownbuttonfield extends StatelessWidget {
  // 2. Définir un paramètre pour la valeur sélectionnée
  final String selectedConfType;
  // 1. Ajouter un paramètre pour la fonction de rappel
  final Function(String?)? onChanged;

  const Dropdownbuttonfield({
    super.key,
    required this.selectedConfType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ), // Exemple : Couleur verte et plus épaisse
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'talk', child: Text('Talk show')),
          DropdownMenuItem(value: 'demo', child: Text('Demo de code')),
          DropdownMenuItem(value: 'partner', child: Text('Partner')),
        ],
        value: selectedConfType,
        onChanged: onChanged,
      ),
    );
  }
}
