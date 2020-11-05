import 'package:tournament/data/cache.dart';
import 'package:tournament/data/network.dart';

class Repository with Network, Cache {
  static Repository _repository;

  static get instance {
    if (_repository == null) {
      _repository = Repository();
    }
    return _repository;
  }

}
