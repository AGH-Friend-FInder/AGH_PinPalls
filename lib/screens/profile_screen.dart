import 'package:flutter/material.dart';

TextStyle mainStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  color: Color(0xff175432),
);
TextStyle secStyle = TextStyle(fontSize: 13, color: Colors.black);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  height: 250,
                  image: AssetImage('assets/profilepin.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text("Name", style: mainStyle),
              Text("Bartek W", style: secStyle),
              const SizedBox(height: 20),
              Text("Email address", style: mainStyle),
              Text("Email address", style: secStyle),
              const SizedBox(height: 20),
              Text("My groups", style: mainStyle),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(4, (index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("Group ${index + 1}", style: secStyle),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Edit Groups"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
