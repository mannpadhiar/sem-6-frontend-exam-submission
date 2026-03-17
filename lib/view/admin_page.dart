import 'package:flutter/material.dart';
import 'package:frontend_test/services/admin_services.dart';
import 'package:frontend_test/view/admin_users_page.dart';

import 'login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Map<String, dynamic> clinicData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Clinic Queue"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("My Clinic", style: TextStyle(color: Colors.white)),
          ),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminUsersPage(),));
            },
            child: Text("Users", style: TextStyle(color: Colors.white)),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white30,
                padding: EdgeInsets.all(10),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
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
      body: Center(
        child: FutureBuilder(
          future: getClinicInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              );
            } else {
              print(snapshot.data);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Clinic Code : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(4))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          snapshot.data!['code'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Users : ${snapshot.data!["userCount"]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Appointments : ${snapshot.data!["appointmentCount"]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
