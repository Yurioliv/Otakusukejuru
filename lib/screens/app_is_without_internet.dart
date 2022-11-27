import 'package:flutter/material.dart';

class AppWithoutInternet extends StatelessWidget {
  const AppWithoutInternet({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff2C2F33),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: mediaquery.size.height * 0.13,
          ),
          const Text(
            'Otakusukejuru',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: mediaquery.size.height * 0.25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Para utilizar este app você precisa de internet!",
              style: TextStyle(fontSize: 28, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
