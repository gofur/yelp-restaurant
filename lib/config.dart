abstract class Config {
  String get apiURL => "";
  String get apiKey => "PTcpJJqBdOY_Fe92qv5mbIm7CCD8SHioo-Dws953Fv9pZI9oLlivoXghYsm8-mjJpPPkDJn3uV02X8fldd2KFIz9meJtG3lVOuMewFK9yDpcoe0KYfegHMKu9aloY3Yx";
}

class DevelopmentConfig extends Config {
  @override
  String get apiURL => "https://api.yelp.com/v3";
}