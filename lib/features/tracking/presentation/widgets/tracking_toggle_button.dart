import 'package:flutter/material.dart';

class TrackingToggleButton extends StatelessWidget {
  final bool isTracking;
  final bool enabled;
  final VoidCallback onPressed;
  final bool isLoading;

  const TrackingToggleButton({
    super.key,
    required this.isTracking,
    required this.enabled,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: enabled ? onPressed : null,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(isTracking ? Icons.stop_circle : Icons.play_circle_fill),
          label: Text(isTracking ? 'Stop Tracking' : 'Start Tracking'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isTracking
                ? colorScheme.error
                : colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            disabledBackgroundColor: colorScheme.surfaceContainerHighest,
            disabledForegroundColor: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
