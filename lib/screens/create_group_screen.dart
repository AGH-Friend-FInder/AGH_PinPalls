import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

List<String> people = ["John Doe"];

class CreateGroupsScreen extends StatelessWidget {
  const CreateGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Column(
                children: [
                  Image(
                    height: 150,
                    image: AssetImage('assets/PinPals_nb.png'),
                  ),
                  Text("Create your group"),
                ],
              ),

              Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Group Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      DropdownSearch<String>.multiSelection(
                        items: (f, cs) => people,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: "Members:",
                            hintText: "Add users who will see your group",
                          ),
                        ),
                        popupProps: PopupPropsMultiSelection.menu(
                          showSearchBox: true,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/groups');
                              },
                              child: Text("Create Group"),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
