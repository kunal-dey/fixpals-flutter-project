import 'dart:convert';

import 'package:get/get.dart';

import '../../core/config/settings.dart';
import 'package:http/http.dart' as http;

class Service {
  final String id;
  final String serviceName;
  final double salePrice;
  final double markedPrice;

  final String description;

  final bool popular;

  final String categoryId;

  final Rx<int> quantity = Rx<int>(0);

  final double? serviceDiscount;
  final String serviceImageUrl;

  Service({
    required this.id,
    required this.serviceName,
    required this.salePrice,
    required this.markedPrice,
    required this.description,
    this.serviceDiscount,
    required this.serviceImageUrl,
    this.popular = false,
    required this.categoryId,
  });
}

final Rx<List<Service>> _popularServices = Rx<List<Service>>([]);

Rx<List<Service>> get popularServices => _popularServices;

void fetchPopularServices() {
  getPopularServices()
      .then((listOfServices) => _popularServices.value = listOfServices);
}

Future<List<Service>> getPopularServices() async {
  final url = Uri.parse(POPULAR_SERVICES);

  List<Service> _fetchedPopularServices = [];

  try {
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final responseData = json.decode(response.body);

    for (int i = 0; i < responseData["data"].length; i++) {
      dynamic _fetchedService = responseData["data"][i];
      _fetchedPopularServices.add(Service(
        id: _fetchedService["_id"],
        serviceName: _fetchedService["title"],
        salePrice: _fetchedService["sale_price"],
        markedPrice: _fetchedService["marked_price"],
        description: _fetchedService["description"],
        serviceDiscount: _fetchedService["discount"],
        serviceImageUrl: "",
        categoryId: _fetchedService["parent_id"],
      ));
    }
    return _fetchedPopularServices;
  } catch (error) {
    return _fetchedPopularServices;
  }
}

final Rx<List<Service>> _searchResults = Rx<List<Service>>([]);

final Rx<bool> searching = Rx<bool>(false);

Rx<List<Service>> get searchResults => _searchResults;

void fetchSearchResults(String text) {
  searching.value = true;
  getSearchResults(text).then((listOfServices) {
    _searchResults.value = listOfServices;
    searching.value = false;
  });
}

Future<List<Service>> getSearchResults(String text) async {
  final url = Uri.parse(SEARCH_PRODUCTS);

  List<Service> _fetchedSearchResults = [];

  try {
    final data = {"search_text": text};

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    final responseData = json.decode(response.body);
    print(responseData);
    for (int i = 0; i < responseData["data"].length; i++) {
      dynamic _fetchedService = responseData["data"][i];
      _fetchedSearchResults.add(Service(
        id: _fetchedService["_id"],
        serviceName: _fetchedService["title"],
        salePrice: _fetchedService["sale_price"],
        markedPrice: _fetchedService["marked_price"],
        description: _fetchedService["description"],
        serviceDiscount: _fetchedService["discount"],
        serviceImageUrl: "",
        categoryId: _fetchedService["parent_id"],
      ));
    }
    print(_fetchedSearchResults);
    return _fetchedSearchResults;
  } catch (error) {
    return _fetchedSearchResults;
  }
}
