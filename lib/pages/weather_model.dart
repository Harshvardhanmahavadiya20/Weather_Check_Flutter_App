class Weather {
  final String cityName;
  final double temperature;
  final String mainCondiation;

  Weather({
    required this.cityName,
    required this.mainCondiation,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      mainCondiation: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
