String formatPrice(String price) {
  price = price.replaceAll(RegExp(r'[^0-9]'), '');

  final buffer = StringBuffer();
  int count = 0;

  for (int i = price.length - 1; i >= 0; i--) {
    buffer.write(price[i]);
    count++;
    if (count == 3 && i != 0) {
      buffer.write(',');
      count = 0;
    }
  }

  return '${buffer.toString().split('').reversed.join('')} ریال';
}

extension PriceFormatter on String {
  String toMoney() => formatPrice(this);
}

extension PriceFormatterInt on int {
  String toMoney() => formatPrice(toString());
}
