import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/officer.jpg'),
            SizedBox(height: 20),
            Text(
              'Información sobre la aplicación',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
