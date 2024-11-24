import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/pages/layout/layout.dart';

import 'bloc/shipping_unit/shipping_unit_bloc.dart';
import 'core/themes/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ShippingUnitBloc(),
        ),
      ],
      child: const MyApp(),
    ));
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AppLayout(),
    );
  }
}
