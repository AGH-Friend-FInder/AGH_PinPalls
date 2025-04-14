import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:flutter/material.dart';

void showMarkerInfo(BuildContext context, MapTagState tagState) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 400,
        alignment: Alignment.topCenter,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Number of people', style: const TextStyle(fontSize: 24)),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black, width: 1.8),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Text(
                  '${tagState.peopleCounter}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const Divider(),
              Text('Tags', style: const TextStyle(fontSize: 24)),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:
                    tagState.selectedTags.map((tag) {
                      return Chip(
                        label: Text(tag.groupName),
                        backgroundColor: Colors.blue.shade300,
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
              ),
              const Divider(),
              Text('Time to expire', style: const TextStyle(fontSize: 24)),
              Text(
                '${tagState.time} min',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    },
  );
}
