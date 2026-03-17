import 'package:flutter/material.dart';
import 'package:frontend_test/view/Receptionist/receptionist_dashboard.dart';
import 'package:frontend_test/view/admin_page.dart';
import 'package:frontend_test/view/patient/patient_dashboard.dart';
import '../services/auth_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

      _email.text = "hh@gmail.com";
      _password.text = "het@1234";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Login",style: TextStyle(color: Colors.blueAccent,fontSize: 24,fontWeight: FontWeight.bold),)),
                  Padding(padding: const EdgeInsets.all(8.0), child: Text("Email")),
                  TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value == null) return "Please Enter Valid Name";
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Password"),
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null) return "Please Enter Valid password";
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: () async{
                        if(formKey.currentState!.validate()) {
                          Map<String,dynamic> data = await loginUser(email: _email.text,password: _password.text);

                          if(data.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email or password')));
                          }

                          if(data["user"]["role"] == "admin"){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage(),));
                          }

                          if(data["user"]["role"] == "patient"){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientDashboard(),));
                          }

                          if(data["user"]["role"] == "receptionist"){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReceptionistDashboard(),));
                          }
                        }

                      },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: Text("LogIn",style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
