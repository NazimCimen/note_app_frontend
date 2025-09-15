/// Constants for Gemini AI service configuration
class GeminiConstants {
  // API Configuration
  static const String apiEndpoint = '/v1beta/models/gemini-2.0-flash-exp:generateContent';
  static const String apiKeyEnvVar = 'GEMINI_API_KEY';
  
  // Generation Configurations
  static const double keywordsTemperature = 0.3;
  static const int keywordsMaxTokens = 100;
  static const double summaryTemperature = 0.5;
  static const int summaryMaxTokens = 500;
  
  // Prompts
  static const String keywordsPrompt = '''Analyze the following text and extract the most important 3-10 keywords. Return the keywords separated by commas. Only return the keywords, no additional explanations.''';
  
  static const String summaryPrompt = '''Summarize the following text. The summary should be approximately 30% of the original text length. Preserve the main ideas while summarizing. Only return the summary, no additional explanations.''';
  
  // Language Instructions
  static const String turkishInstruction = 'Respond in Turkish language.';
  static const String englishInstruction = 'Respond in English language.';
  
  
  // Locale
  static const String turkishLocalePrefix = 'tr';
}
