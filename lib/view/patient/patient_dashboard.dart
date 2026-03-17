import 'package:flutter/material.dart';
import 'package:frontend_test/view/login_page.dart';
import 'package:frontend_test/view/patient/patient_book_appointment_page.dart';
import 'package:frontend_test/view/patient/patient_my_appointment_page.dart';
import 'package:frontend_test/view/patient/patient_my_prescription_page.dart';
import 'package:frontend_test/view/patient/patient_my_report_page.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyAppointmentPage(),));
            },
            child: const Text("My Appointment", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyPrescriptionPage(),));
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

      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientDashboard(),)), child: Text("Dashboard")),
                  ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyAppointmentPage(),)), child: Text("My Appointment")),
                  ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyPrescriptionPage(),)), child: Text("My Prescription")),
                  ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientMyReportPage(),)), child: Text("My Report")),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
