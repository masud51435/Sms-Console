abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

///  when a UseCase doesn't require any parameters.
class NoParams {}
