import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/tracking/presentation/bloc/tracking_bloc.dart';
import 'features/tracking/presentation/pages/tracking_page.dart';
import 'injection_container.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrackingBloc>(create: (_) => di.sl<TrackingBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Tracker',

        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

        home: const TrackingPage(),
      ),
    );
  }
}
