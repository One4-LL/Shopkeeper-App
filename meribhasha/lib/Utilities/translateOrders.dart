import 'netwok.dart';

class TranslateOrders {
  Future<dynamic> getTranslatedOrders() async {
    NetworkHelper networkHelper =
        NetworkHelper('http://ishankdev.pythonanywhere.com/query-example');
    var translatedOrder = await networkHelper.getData();
    print(translatedOrder);
    return translatedOrder;
  }
}
