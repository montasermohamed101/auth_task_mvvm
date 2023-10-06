import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:intern/domain/repo/auth_repo/auth_repo.dart';

import '../../../UI/utils/shared_prefrences_utils.dart';
import '../../base_error.dart';
import 'package:http/http.dart' as http;

import '../../model/auth/auth_model.dart';

class AuthRepoImpl extends AuthRepo{

  @override
  Future<Either<BaseError,AuthResponse>> login({required String username, required String password})async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi
        || connectivityResult == ConnectivityResult.mobile) {
      Uri url = Uri.parse("https://dummyjson.com/auth/login");

       http.Response response = await http.post(url,body: {
        "username":username,
        "password":password,

      },

      );
      print("This is the result ${response.body}");
      var json = jsonDecode(response.body);
      var authResponse = AuthResponse.fromJson(json);
      if(response.statusCode >= 200 && response.statusCode < 300){
        await SharedPrefsUtils.saveUser(authResponse);
        await  SharedPrefsUtils.saveToken(authResponse.token!);
        return Right(authResponse);

      }else{
        return Left(BaseError(message:authResponse.message!));
      }

    }else{
      return Left(BaseError(message: "Please Check your Internet"));
    }

  }








  @override
  Future<bool> isAuthorized() async{
    AuthResponse?  user = await  SharedPrefsUtils.getUser();
    return user != null ;
  }
}