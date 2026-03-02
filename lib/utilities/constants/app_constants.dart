class AppConstants {
  // static const String apiKey = 'AIzaSyDHEKCLXA65ozHNwV1ThdkGxrGNVP_DL6Y';
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
}
