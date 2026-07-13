import 'package:dartz/dartz.dart';


abstract class BookingRemoteDataSource {
  Future<Unit> callApi();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  BookingRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  