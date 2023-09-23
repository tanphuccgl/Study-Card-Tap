import 'repositories/user/user_repository.dart';
import 'repositories/user/user_repository_impl.dart';

class Domain {
  static Domain? _internal;
  factory Domain() {
    _internal ??= Domain._();

    return _internal!;
  }
  late UserRepository userRepository;

  Domain._() {
    userRepository = UserRepositoryImpl();
  }
}
