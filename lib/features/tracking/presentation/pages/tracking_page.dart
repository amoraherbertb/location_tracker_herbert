import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker_exam/features/tracking/presentation/widgets/tracking_toggle_button.dart';

import '../../../../injection_container.dart';

import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_event.dart';
import '../bloc/tracking_state.dart';

import '../widgets/filter_dropdown.dart';
import '../widgets/tracking_list.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TrackingBloc>(),
      child: const _TrackingView(),
    );
  }
}

class _TrackingView extends StatelessWidget {
  const _TrackingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker'), centerTitle: true),
      body: BlocConsumer<TrackingBloc, TrackingState>(
        listener: (context, state) {
          if (state.status == TrackingStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.status == TrackingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const SizedBox(height: 16),

              TrackingToggleButton(
                isTracking: state.status == TrackingStatus.tracking,
                enabled: state.status != TrackingStatus.loading,
                isLoading: state.status == TrackingStatus.loading,
                onPressed: () {
                  final bloc = context.read<TrackingBloc>();

                  if (state.status == TrackingStatus.tracking) {
                    bloc.add(const TrackingStopped());
                  } else {
                    bloc.add(const TrackingStarted());
                  }
                },
              ),

              const SizedBox(height: 16),

              FilterDropdown(
                selectedValue: state.selectedFilter,
                onChanged: (value) {
                  if (value != null) {
                    context.read<TrackingBloc>().add(
                      TrackingFilterChanged(value),
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              if (state.target != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.place),
                      title: const Text('Target Location'),
                      subtitle: Text(
                        '${state.target!.targetLat}, ${state.target!.targetLng}',
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              Expanded(
                child: state.records.isEmpty
                    ? const Center(
                        child: Text(
                          'No tracking records yet.\nPress Start Tracking to begin.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : TrackingList(records: state.records),
              ),
            ],
          );
        },
      ),
    );
  }
}
