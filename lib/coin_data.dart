import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '54B54ABA-93FC-4BAC-85B7-C03AD65A8C5C';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      //TODO 5: Return a Map of the results instead of a single value.
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      var url = Uri.parse(requestURL);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
