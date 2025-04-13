import 'package:agh_pin_palls/models/pin.dart';
import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider.dart';

// final List<String> _tags = [
//   "Friends",
//   "Public",
//   "Informatyka",
//   "Coin",
//   "Cyberka",
//   "Algo",
//   "WO",
//   "test1",
//   "test2",
//   "test3",
//   "test4",
//   "test5",
//   "test6",
//   "test7",
//   "test8",
//   "test9",
//   "test0",
// ];

Future<bool> showMapBottomModal(
  BuildContext context,
  MapTagState tagState,
) async {
  await Provider.of<GroupProvider>(
    context,
    listen: false,
  ).fetchGroupsFromUserId(
    Provider.of<UserProvider>(context, listen: false).user!.id,
  );

  if (context.mounted) {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ModalContent(tagState: tagState);
          },
        );
      },
    );

    if (result != null) return true;
  }

  return false;
}

class ModalContent extends StatelessWidget {
  const ModalContent({super.key, required this.tagState});

  final MapTagState tagState;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      expand: false,
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Center(child: _PeopleCounter(tagState: tagState)),
                const Divider(),
                Center(
                  child: SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: _TagSelector(tagState: tagState),
                    ),
                  ),
                ), // _TagSelector
                const SizedBox(height: 12),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed:
                      () => {
                        Provider.of<PinProvider>(
                          context,
                          listen: false,
                        ).publishPin(
                          Pin(
                            numberOfPeople: tagState.peopleCounter,
                            pin: "placeholder",
                            latitude: tagState.position!.latitude,
                            longitude: tagState.position!.longitude,
                            expireAtMinutes: 20,
                            hostUserId:
                                Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).user!.id,
                            groupsId:
                                tagState.selectedTags
                                    .map((tag) => tag.id)
                                    .toList(),
                          ),
                        ),

                        Navigator.pop(context, true),
                      },
                ),

                const Divider(),
                Center(
                  child: Column(
                    children: [
                      Text('Timer', style: const TextStyle(fontSize: 24)),
                      Center(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '-30',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '-15',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Time',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '+15',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '+30',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     ElevatedButton(
                      //         onPressed: () {},
                      //         child: const Text('-15')
                      //     ),
                      //     ElevatedButton(
                      //         onPressed: () {},
                      //         child: const Text('+15')
                      //     ),
                      //     ElevatedButton(
                      //         onPressed: () {},
                      //         child: const Text('+30')
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PeopleCounter extends StatefulWidget {
  const _PeopleCounter({required this.tagState});

  final MapTagState tagState;

  @override
  State<_PeopleCounter> createState() => _PeopleCounterState();
}

class _PeopleCounterState extends State<_PeopleCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black, width: 1.8),
      //   borderRadius: BorderRadius.circular(30),
      // ),
      child: Center(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    widget.tagState.decrementPeopleCount();
                  });
                },
              ),
            ),
            // Odstęp między przyciskami
            const SizedBox(width: 0),
            // Wyświetlanie aktualnego stanu licznika
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${widget.tagState.peopleCounter}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 0),
            // Przycisk zwiększania
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    widget.tagState.incrementPeopleCount();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagSelector extends StatefulWidget {
  const _TagSelector({required this.tagState});

  final MapTagState tagState;
  //final List<String> _tags = get

  @override
  State<_TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<_TagSelector> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children:
          Provider.of<GroupProvider>(context, listen: false).userGroups.map((
            tag,
          ) {
            final isSelected = widget.tagState.selectedTags.contains(tag);

            return ChoiceChip(
              label: Text(tag.groupName),
              selected: isSelected,
              onSelected: (bool value) {
                setState(() {
                  if (value) {
                    // Dodajemy tag do zaznaczonych
                    widget.tagState.selectedTags.add(tag);
                  } else {
                    // Usuwamy tag z zaznaczonych
                    widget.tagState.selectedTags.remove(tag);
                  }
                });
              },
              selectedColor: Colors.blue.shade300,
              disabledColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            );
          }).toList(),
    );
  }
}

// class _Timer extends StatefulWidget {
//   const _Timer({super.key});
//
//
//
//   @override
//   State<_Timer> createState() => _TimerState();
// }
//
// class _TimerState extends State<_Timer> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
