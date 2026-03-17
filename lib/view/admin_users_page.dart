import 'package:flutter/material.dart';
import 'package:frontend_test/services/admin_services.dart';
import 'package:frontend_test/view/login_page.dart';
import 'admin_page.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  List<String> list = <String>['admin', 'patient', 'receptionist', 'doctor'];

  String dropdownvalue = 'patient';

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
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            },
            child: const Text(
              "My Clinic",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Users", style: TextStyle(color: Colors.white)),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Clinic Users',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_name, "Name")),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            _password,
                            "Password",
                            obscure: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_email, "Email")),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTextField(_phone, "Phone")),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(12),
                            value: dropdownvalue,
                            icon: const Icon(Icons.dehaze_rounded,color: Colors.blue,),
                            elevation: 0,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownvalue = value!;
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final res = await addUsers({
                          "name": _name.text,
                          "email": _email.text,
                          "password": _password.text,
                          "role": dropdownvalue,
                          "phone": _phone.text,
                        });
                        setState(() {});

                        if(res.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter valid data'),backgroundColor: Colors.red,));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User added'),backgroundColor: Colors.green,));
                        }
                        print("user added!!!");
                      },
                      child: const Text('Add User'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // LIST SECTION
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final users = snapshot.data ?? [];

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(snapshot.data![index]['name'] ?? 'No Name'),
                        subtitle: Text(snapshot.data![index]['email']),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(snapshot.data![index]['role']),
                            Text(
                              snapshot.data![index]['phone'] == ''
                                  ? "-- -- --"
                                  : snapshot.data![index]['phone'],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
