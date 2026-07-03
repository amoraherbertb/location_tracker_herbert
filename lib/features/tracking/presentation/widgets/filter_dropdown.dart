import 'package:flutter/material.dart';
import 'package:location_tracker_exam/core/constants/app_constants.dart';

class FilterDropdown extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int?> onChanged;

  const FilterDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            'Show Recent:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<int>(
              initialValue: selectedValue,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items: AppConstants.filterOptions.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value readings'),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
