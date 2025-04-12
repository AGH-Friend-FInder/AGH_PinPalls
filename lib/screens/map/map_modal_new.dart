import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:flutter/material.dart';

final List<String> _tags = [
  "Friends",
  "Public",
  "Informatyka",
  "Coin",
  "Cyberka",
  "Algo",
  "WO",
  "test1",
  "test2",
  "test3",
  "test4",
  "test5",
  "test6",
  "test7",
  "test8",
  "test9",
  "test0",
];

Future<bool> showMapBottomModal(
  BuildContext context,
  MapTagState tagState,
) async {
  final result = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return ModalContent(tagState: tagState);
        },
      );
    },
  );

  if (result != null) return true;
  return false;
}

class ModalContent extends StatelessWidget {
  const ModalContent({super.key, required this.tagState});

  final MapTagState tagState;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: _PeopleCounter(tagState: tagState),
                ),

                _TagSelector(tagState: tagState),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//   SizedBox(
//   height: 300,
//   child: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           width: 40,
//           height: 4,
//           margin: const EdgeInsets.only(bottom: 12),
//           decoration: BoxDecoration(
//             color: Colors.grey[400],
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 8,
//           ),
//           width: 200,
//           height: 50,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 1.4),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: _PeopleCounter(tagState: tagState),
//         ),
//         _TagSelector(tagState: tagState),
//         ElevatedButton(
//           child: const Text('Submit'),
//           onPressed: () => Navigator.pop(context, true),
//         ),
//       ],
//     ),
//   ),
// );
//   }
// }

class _PeopleCounter extends StatefulWidget {
  const _PeopleCounter({required this.tagState});

  final MapTagState tagState;

  @override
  State<_PeopleCounter> createState() => _PeopleCounterState();
}

class _PeopleCounterState extends State<_PeopleCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              widget.tagState.decrementCounter();
            });
          },
        ),
        // Odstęp między przyciskami
        const SizedBox(width: 20),
        // Wyświetlanie aktualnego stanu licznika
        Text(
          '${widget.tagState.counter}',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(width: 20),
        // Przycisk zwiększania
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.tagState.incrementCounter();
            });
          },
        ),
      ],
    );
  }
}

class _TagSelector extends StatefulWidget {
  const _TagSelector({required this.tagState});

  final MapTagState tagState;

  @override
  State<_TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<_TagSelector> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children:
            _tags.map((tag) {
              final isSelected = widget.tagState.selectedTags.contains(tag);

              return ChoiceChip(
                label: Text(tag),
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
      ),
    );
  }
}
