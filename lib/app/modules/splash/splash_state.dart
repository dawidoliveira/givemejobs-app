class SplashState {
  double? height;
  int? durationInSeconds;

  SplashState({
    this.height,
    this.durationInSeconds,
  });

  factory SplashState.initialState() {
    return SplashState(
      height: 0,
      durationInSeconds: 1,
    );
  }

  SplashState copyWith({
    int? durationInSeconds,
    double? height,
  }) {
    return SplashState(
      height: height ?? this.height,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
    );
  }
}
