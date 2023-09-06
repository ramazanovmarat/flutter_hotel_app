import 'dart:io';
import 'package:hotel/feature/presentation/bloc/booking_cubit/booking_cubit.dart';
import 'package:hotel/feature/presentation/bloc/hotel_cubit.dart';
import 'package:hotel/feature/presentation/bloc/numbers_cubit/number_cubit.dart';
import 'package:hotel/feature/presentation/presentation/hotel_screen.dart';

import 'locator_service.dart';
import 'package:flutter/material.dart';
import 'package:hotel/theme.dart';
import 'package:hotel/locator_service.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HotelCubit>(create: (context) => sl<HotelCubit>()..loadHotel()),
        BlocProvider<NumberCubit>(create: (context) => sl<NumberCubit>()..loadNumbers()),
        BlocProvider<BookingCubit>(create: (context) => sl<BookingCubit>()..loadBooking()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        home: const HotelScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

