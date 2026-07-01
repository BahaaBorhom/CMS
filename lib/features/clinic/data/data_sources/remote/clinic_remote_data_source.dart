import 'package:dartz/dartz.dart';


abstract class ClinicRemoteDataSource {
  Future<Unit> callApi();
}

class ClinicRemoteDataSourceImpl implements ClinicRemoteDataSource {
  ClinicRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  