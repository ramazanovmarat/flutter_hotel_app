import 'package:get_it/get_it.dart';
import 'package:hotel/core/platform/network_info.dart';
import 'package:hotel/feature/data/datasources/booking_remote_data_source.dart';
import 'package:hotel/feature/data/datasources/hotel_remote_data_source.dart';
import 'package:hotel/feature/data/datasources/selction_number_remote_data_source.dart';
import 'package:hotel/feature/data/repositories/booking_repository_impl.dart';
import 'package:hotel/feature/data/repositories/hotel_repository_impl.dart';
import 'package:hotel/feature/data/repositories/selection_number_repository_impl.dart';
import 'package:hotel/feature/domain/repository/booking_repository.dart';
import 'package:hotel/feature/domain/repository/hotel_repository.dart';
import 'package:hotel/feature/domain/repository/selection_number_repositoty.dart';
import 'package:hotel/feature/domain/usecases/get_booking.dart';
import 'package:hotel/feature/domain/usecases/get_hotels.dart';
import 'package:hotel/feature/domain/usecases/get_numbers.dart';
import 'package:hotel/feature/presentation/bloc/booking_cubit/booking_cubit.dart';
import 'package:hotel/feature/presentation/bloc/hotel_cubit.dart';
import 'package:hotel/feature/presentation/bloc/numbers_cubit/number_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Cubit
  sl.registerFactory(() => HotelCubit(getHotels: sl<GetHotels>()));

  sl.registerFactory(() => NumberCubit(getNumbers: sl<GetNumbers>()));

  sl.registerFactory(() => BookingCubit(getBooking: sl<GetBooking>()));

  // UseCases
  sl.registerLazySingleton(() => GetHotels(sl()));

  sl.registerLazySingleton(() => GetNumbers(sl()));

  sl.registerLazySingleton(() => GetBooking(sl()));

  // Repository
  sl.registerLazySingleton<HotelRepository>(() =>
      HotelRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl(),
      ));

  sl.registerLazySingleton<SelectionNumberRepository>(() =>
      SelectionNumberRepositoryImpl(
          selectionNumberDataSource: sl(),
          networkInfo: sl(),
      ));

  sl.registerLazySingleton<BookingRepository>(() =>
      BookingRepositoryImpl(
        bookingRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<HotelRemoteDataSource>(() => HotelRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<SelectionNumberDataSource>(() => SelectionNumberDataSourceImpl(client: sl()));

  sl.registerLazySingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl(client: sl()));


  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
