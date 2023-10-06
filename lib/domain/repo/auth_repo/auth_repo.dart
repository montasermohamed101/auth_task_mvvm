import 'package:dartz/dartz.dart';
import 'package:intern/data/base_error.dart';
import 'package:intern/data/model/auth/auth_model.dart';

abstract class AuthRepo{

  Future<Either<BaseError,AuthResponse>> login({required String username,required String password});
  // Future<Either<BaseError,AuthModel>> register({required String email,required String password});
  Future<bool> isAuthorized();


}