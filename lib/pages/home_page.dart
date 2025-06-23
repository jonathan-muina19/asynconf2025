import 'package:asynconf2025/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1877F2),
        centerTitle: true,
        title: Text(
          'Asynconf 2025',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                color: Color(0xFF1877F2),
              ),
              SizedBox(height: 10),
              Text(
                'Asynconf 2025',
                style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
              ),
              Text(
                'Salon virtuel de la programmation du 30 au 21 juillet 2025',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
