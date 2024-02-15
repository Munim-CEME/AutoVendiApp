

abstract class BaseUseCase<In, Out> {
  Future<Out> execute(In input);
}
