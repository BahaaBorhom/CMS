import 'package:dartz/dartz.dart';


abstract class SearchRemoteDataSource {
  Future<Unit> callApi();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl();

  @override
  Future<Unit> callApi() async {
    // send api request here
    return Future.value(unit);
  }

}


  