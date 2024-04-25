class ApiCall {
  static String baseURL =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=";

  static const int receiveTimeout = 15;
  static const int connectionTimeout = 15;
}

enum Endpoints {
  getNews('e7a87d78fb5f44af8e2ccaf1911ece57');

  final String endpoint;
  const Endpoints(this.endpoint);
}
