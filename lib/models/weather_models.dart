class WeatherModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnits? currentUnits;
  Current? current;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
  });

  WeatherModel copyWith({
    double? latitude,
    double? longitude,
    double? generationtimeMs,
    int? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    double? elevation,
    CurrentUnits? currentUnits,
    Current? current,
  }) =>
      WeatherModel(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        generationtimeMs: generationtimeMs ?? this.generationtimeMs,
        utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
        timezone: timezone ?? this.timezone,
        timezoneAbbreviation: timezoneAbbreviation ?? this.timezoneAbbreviation,
        elevation: elevation ?? this.elevation,
        currentUnits: currentUnits ?? this.currentUnits,
        current: current ?? this.current,
      );

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        currentUnits: json["current_units"] == null ? null : CurrentUnits.fromJson(json["current_units"]),
        current: json["current"] == null ? null : Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_units": currentUnits?.toJson(),
        "current": current?.toJson(),
      };
}

class Current {
  String? time;
  int? interval;
  double? temperature2M;
  double? windSpeed10M;

  Current({
    this.time,
    this.interval,
    this.temperature2M,
    this.windSpeed10M,
  });

  Current copyWith({
    String? time,
    int? interval,
    double? temperature2M,
    double? windSpeed10M,
  }) =>
      Current(
        time: time ?? this.time,
        interval: interval ?? this.interval,
        temperature2M: temperature2M ?? this.temperature2M,
        windSpeed10M: windSpeed10M ?? this.windSpeed10M,
      );

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"]?.toDouble(),
        windSpeed10M: json["wind_speed_10m"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
        "wind_speed_10m": windSpeed10M,
      };
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2M;
  String? windSpeed10M;

  CurrentUnits({
    this.time,
    this.interval,
    this.temperature2M,
    this.windSpeed10M,
  });

  CurrentUnits copyWith({
    String? time,
    String? interval,
    String? temperature2M,
    String? windSpeed10M,
  }) =>
      CurrentUnits(
        time: time ?? this.time,
        interval: interval ?? this.interval,
        temperature2M: temperature2M ?? this.temperature2M,
        windSpeed10M: windSpeed10M ?? this.windSpeed10M,
      );

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"],
        windSpeed10M: json["wind_speed_10m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
        "wind_speed_10m": windSpeed10M,
      };
}
