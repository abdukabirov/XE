import 'package:dio/dio.dart';

class CryptoModel {
  final String name;
  final double price;
  final String image;
  final double percent;
  final bool isPriceIncreasing;

  CryptoModel({
    required this.name,
    required this.price,
    required this.image,
    required this.percent,
    required this.isPriceIncreasing,
  });
}

class Coins {
  Future<List<CryptoModel>> getCrypto() async {
    List<String> list = [
      'AAVE',
      'ATOM',
      'AVAX',
      'BTC',
      'DOGE',
      'DOT',
      'EOS',
      'ETH',
      'LTC',
      'LINK',
      'PNT',
      'TON',
      '1INCH',
      'XLM',
      'XRP',
      'ADA',
      'BNB',
      'SOL',
      'FIL',
      'USDT',
      'MATIC',
      'XMR',
      'NEO',
      'BCH',
      'ETC',
      'ICP',
      'VET',
      'AAVE',
      'MKR',
      'COMP',
      'ZEC',
      'ICX',
      'WAVES',
      'QTUM',
      'YFI',
      'SUSHI',
      'ATOM',
      'ALGO',
      'ZRX',
      'OMG',
    ];
    list.sort();
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=${list.join(',')}&tsyms=USD');

    final api = response.data as Map<String, dynamic>;
    final dataRaw = api['RAW'] as Map<String, dynamic>;

    return dataRaw.entries.map((e) {
      final data =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = data['PRICE'];
      final image = data['IMAGEURL'];
      final percent = data['CHANGEPCT24HOUR'];
      final isPriceIncreasing = percent >= 0;
      return CryptoModel(
        name: e.key,
        price: price,
        image: 'https://www.cryptocompare.com/$image',
        percent: percent,
        isPriceIncreasing: isPriceIncreasing,
      );
    }).toList();
  }
}
