import 'package:flutter/material.dart';
import 'package:intern/UI/utils/shared_prefrences_utils.dart';
import 'package:intern/data/model/auth/auth_model.dart';

import 'auth/login/login.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AuthResponse?>(
        future: SharedPrefsUtils.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 220,
                        margin: const EdgeInsets.all(16.0),
                      ),
                      Image.asset(
                        'assets/ic_top.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        child: Card(
                          child: Image.network(
                            '${user.image}',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildFormField("Name", user.username ?? 'N/A'),
                            buildFormField("Email", user.email ?? 'N/A'),
                            buildFormField("Gender", user.firstName ?? 'N/A'),
                            // You can add more fields here
                          ],
                        ),
                      ),
                      MaterialButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          minWidth: double.infinity,
                          height: 44,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onPressed: () async {
                            await SharedPrefsUtils.clearUser();
                            await SharedPrefsUtils.clearToken();
                            Navigator.of(context).pushReplacementNamed(Login.routeName);
                          },
                          child: const Text("Log Out")),
                    ],
                  ),
                ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No user data available."),
            );
          }
        },
      ),
    );
  }

  Widget buildFormField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),


      ],
    );
  }
}
