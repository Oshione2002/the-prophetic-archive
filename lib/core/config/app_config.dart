class AppConfig {
  static const authenticCatalogueUrl =
      'https://raw.githubusercontent.com/Oshione2002/'
      'the-prophetic-archive-content/main/catalogue.json';

  const AppConfig({
    required this.environment,
    required this.catalogueUrl,
    required this.aiBaseUrl,
  });

  factory AppConfig.fromEnvironment() {
    const environment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const catalogueUrl = String.fromEnvironment(
      'ARCHIVE_CATALOGUE_URL',
      defaultValue: authenticCatalogueUrl,
    );
    const aiBaseUrl = String.fromEnvironment('AI_BASE_URL');
    if (environment == 'production') {
      if (!catalogueUrl.startsWith('https://')) {
        throw StateError('Production requires an HTTPS ARCHIVE_CATALOGUE_URL.');
      }
      if (aiBaseUrl.isNotEmpty && !aiBaseUrl.startsWith('https://')) {
        throw StateError('Production AI_BASE_URL must use HTTPS.');
      }
    }
    return const AppConfig(
      environment: environment,
      catalogueUrl: catalogueUrl,
      aiBaseUrl: aiBaseUrl,
    );
  }

  final String environment;
  final String catalogueUrl;
  final String aiBaseUrl;

  bool get isDevelopment => environment != 'production';
  bool get hasAIEndpoint => aiBaseUrl.isNotEmpty;
}
