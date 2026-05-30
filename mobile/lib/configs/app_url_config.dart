class AppUrlConfig {
  final String _domain = 'https://n8n.dpnaco.com/';
  final String _domainExt = 'webhook';
  static const String consumers = 'getConsumers';
  static const String result = 'dataProcess';

  String getUrl(String domain) {
    return '$_domain/$_domainExt/$domain';
  }
}
