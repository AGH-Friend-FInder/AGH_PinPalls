import 'package:agh_pin_palls/models/group.dart';
import 'package:agh_pin_palls/provider.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

List<String> tags = ["Informatyka", "Wydział Ceramiki", "Kulturoznawstwo"];

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GroupProvider groupProvider = GroupProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
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
                  Text("Group panel"),
                ],
              ),

              Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: groupProvider.fetchPublicGroups(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            return Scaffold(
                              body: Center(
                                child: Text('Error: ${snapshot.error}'),
                              ),
                            );
                          } else {
                            return DropdownSearch<Group>.multiSelection(
                              items: groupProvider.getPublicGroups,
                              itemAsString: (i) => i.groupName,
                              compareFn: (i, s) => i.id == s.id,
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  labelText: "Your groups:",
                                  hintText: "Add groups you'd like to follow",
                                ),
                              ),
                              popupProps: PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/groups/create');
                              },
                              child: Text("Create your group"),
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
