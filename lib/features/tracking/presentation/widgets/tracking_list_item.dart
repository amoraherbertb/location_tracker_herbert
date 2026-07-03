import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/distance_formatter.dart';

import '../../domain/entities/tracking_record.dart';

class TrackingListItem extends StatelessWidget {
  final TrackingRecord record;

  const TrackingListItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.location_on)),
        title: Text(
          DateFormatter.format(record.timestamp),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text('Latitude: ${record.latitude.toStringAsFixed(6)}'),

            Text('Longitude: ${record.longitude.toStringAsFixed(6)}'),

            const SizedBox(height: 4),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Divider(height: 1),
            ),

            Text(
              'Distance: ${DistanceFormatter.format(record.distance)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
