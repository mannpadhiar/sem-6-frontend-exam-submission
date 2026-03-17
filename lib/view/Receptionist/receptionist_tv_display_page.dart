import 'package:flutter/material.dart';
import 'package:frontend_test/view/Receptionist/receptionist_dashboard.dart';

import '../login_page.dart';

class ReceptionistTvDisplayPage extends StatefulWidget {
  const ReceptionistTvDisplayPage({super.key});

  @override
  State<ReceptionistTvDisplayPage> createState() => _ReceptionistTvDisplayPageState();
}

class _ReceptionistTvDisplayPageState extends State<ReceptionistTvDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Clinic Queue",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ReceptionistDashboard(),
                ),
              );
            },
            child: const Text(
              "Queue(manage)",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {

            },
            child: const Text(
              "Book Appointment",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
