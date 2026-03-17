import 'package:flutter/material.dart';
import 'package:frontend_test/services/prescription_services.dart';
import 'package:frontend_test/view/patient/patient_book_appointment_page.dart';
import 'package:frontend_test/view/patient/patient_dashboard.dart';
import 'package:frontend_test/view/patient/patient_my_report_page.dart';

import '../../services/appintment_services.dart';
import '../login_page.dart';

class PatientMyPrescriptionPage extends StatefulWidget {
  const PatientMyPrescriptionPage({super.key});

  @override
  State<PatientMyPrescriptionPage> createState() => _PatientMyPrescriptionPageState();
}

class _PatientMyPrescriptionPageState extends State<PatientMyPrescriptionPage> {
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientDashboard(),));
            },
            child: const Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientBookAppointmentPage(),));
            },
            child: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
            },
            child: const Text("My Appointment", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
            },
            child: const Text("My Prescription", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyReportPage(),));
            },
            child: const Text("My Report", style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getMyPrescription(), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final users = snapshot.data ?? [];

              return users.isEmpty? Center(child: Text("No Data")) : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                itemBuilder: (context, index) {

                  final user = users[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data![index]['medicines']['name']),
                          Text(snapshot.data![index]['medicines']['dosage']),
                          Text(snapshot.data![index]['medicines']['duration']),
                        ],
                      ),
                      subtitle: Text(snapshot.data![index]['notes']),
                    ),
                  );
                },
              );
            },),
          )
        ],
      ),
    );
  }
}
