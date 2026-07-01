import 'package:dartz/dartz.dart';


abstract class MapRemoteDataSource {
  Future<Unit> callApi();
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  MapRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  