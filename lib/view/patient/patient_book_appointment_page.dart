import 'package:flutter/material.dart';
import 'package:frontend_test/view/patient/patient_dashboard.dart';
import 'package:frontend_test/view/patient/patient_my_appointment_page.dart';
import 'package:frontend_test/view/patient/patient_my_prescription_page.dart';
import 'package:frontend_test/view/patient/patient_my_report_page.dart';
import 'package:intl/intl.dart';

import '../../services/appintment_services.dart';
import '../login_page.dart';

class PatientBookAppointmentPage extends StatefulWidget {
  const PatientBookAppointmentPage({super.key});

  @override
  State<PatientBookAppointmentPage> createState() => _PatientBookAppointmentPageState();
}

class _PatientBookAppointmentPageState extends State<PatientBookAppointmentPage> {
  final TextEditingController dateController = TextEditingController();
  String? selectedTime;

  final List<String> _timeSlots = [
    "09:00-09:30", "09:30-10:00", "10:00-10:30", "10:30-11:00",
    "11:00-11:30"
  ];

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Book Appointment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: const InputDecoration(
                        labelText: 'Select Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      value: selectedTime,
                      decoration: const InputDecoration(
                        labelText: 'Select Time Slot',
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                      items: _timeSlots.map((String slot) {
                        return DropdownMenuItem<String>(
                          value: slot,
                          child: Text(slot),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTime = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async{

                          final res = await addAppointment({
                            "appointmentDate": dateController.text,
                            "timeSlot": selectedTime
                          });

                          if(dateController.text.isNotEmpty && selectedTime != null && res.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booked for ${dateController.text} at $selectedTime'))
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booked for ${dateController.text} at $selectedTime',),backgroundColor: Colors.green,),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text("Confirm Appointment", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}