import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:flutter/material.dart';

void showMarkerInfo(BuildContext context, MapTagState tagState) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                child: Text(
                  '${tagState.peopleCounter}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:
                    tagState.selectedTags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue.shade300,
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
