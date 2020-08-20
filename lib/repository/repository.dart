import 'package:tournament/data/cache.dart';

class Repository{
  ///Singelton
  Repository._();
  static final Repository _repository=Repository._();
  factory Repository()=>_repository;

  Cache _cache=Cache();


  /// Cache
  Future<String> get getUserToken=>_cache.getUserToken();
  Future<bool> setUserToken(String token)=>_cache.setUserToken(token);
  Future<bool> get removeUserToken=>_cache.removeUserToken();
  Future<bool> get isUserRegistered=>_cache.isUserRegistered();
  


}