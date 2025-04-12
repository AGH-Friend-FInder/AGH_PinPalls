import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(30.0),
                child:

                Column(
                    children: [

                      Column(children:[
                        Image(height: 150,
                            image: AssetImage('assets/PinPals_nb.png')),
                        Text("Welcome! Please Log in.")
                      ]),

                      Form(
                          child:
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.0),
                              child: Column(
                                  children: [
                                    TextFormField(decoration: InputDecoration(labelText: "Email",
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    ),
                                    const SizedBox(height: 20),

                                    TextFormField(decoration: InputDecoration(labelText: "Password",
                                      border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),)),
                                    const SizedBox(height: 20),
                                    Row(  mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          SizedBox(child: ElevatedButton(onPressed: (){}, child: Text("Sign in"),)),
                                          const SizedBox(width: 20),
                                          SizedBox(child: OutlinedButton(onPressed: (){}, child: Text("Register")))
                                        ]

                                    ),

                                  ]
                              )
                          )
                      )
                    ]

                )

            )
        )
    );
  }
}