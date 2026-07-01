import 'package:dartz/dartz.dart';


abstract class AppointmentRemoteDataSource {
  Future<Unit> callApi();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  AppointmentRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  