import 'package:flutter/material.dart';

import '../../domain/entities/tracking_record.dart';

import 'tracking_list_item.dart';

class TrackingList extends StatelessWidget {
  final List<TrackingRecord> records;

  const TrackingList({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: records.length,
      itemBuilder: (context, index) {
        return TrackingListItem(record: records[index]);
      },
    );
  }
}
