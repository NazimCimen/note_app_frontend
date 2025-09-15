import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/error/dio_error_handler.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/shared/constants/gemini_constants.dart';

/// Abstract service for Google Gemini AI operations
abstract class GeminiService {
  /// Generate keywords for given content
  Future<Either<Failure, String>> generateKeywords(
    String content,
    String locale,
  );

  /// Generate summary for given content
  Future<Either<Failure, String>> generateSummary(
    String content,
    String locale,
  );
}

/// Implementation of GeminiService using Google Gemini API
class GeminiServiceImpl implements GeminiService {
  final Dio _dio;

  GeminiServiceImpl({required Dio dio}) : _dio = dio;

  /// Get API key from environment variables
  Either<Failure, String> _getApiKey() {
    final apiKey = dotenv.env[GeminiConstants.apiKeyEnvVar];
    if (apiKey == null || apiKey.isEmpty) {
      return left(ServerFailure(errorMessage: StringConstants.geminiApiKeyNotFound));
    }
    return right(apiKey);
  }

  /// Get language instruction based on locale
  String _getLanguageInstruction(String locale) {
    return locale.startsWith(GeminiConstants.turkishLocalePrefix)
        ? GeminiConstants.turkishInstruction
        : GeminiConstants.englishInstruction;
  }

  /// Build prompt with language instruction
  String _buildPrompt(String basePrompt, String languageInstruction, String content) {
    return '$basePrompt $languageInstruction\n\nText: $content';
  }

  /// Parse Gemini API response
  Either<Failure, String> _parseResponse(Map<String, dynamic>? data) {
    if (data == null || data['candidates'] == null) {
      return left(ServerFailure(errorMessage: 'Invalid response format'));
    }

    final candidates = data['candidates'] as List;
    if (candidates.isEmpty) {
      return left(ServerFailure(errorMessage: 'No candidates in response'));
    }

    final content = candidates[0]['content'] as Map<String, dynamic>?;
    if (content == null || content['parts'] == null) {
      return left(ServerFailure(errorMessage: 'Invalid content format'));
    }

    final parts = content['parts'] as List;
    if (parts.isEmpty) {
      return left(ServerFailure(errorMessage: 'No parts in content'));
    }

    final text = parts[0]['text'] as String?;
    if (text == null || text.isEmpty) {
      return left(ServerFailure(errorMessage: 'Empty response text'));
    }

    return right(text.trim());
  }

  /// Make request to Gemini API
  Future<Either<Failure, String>> _makeRequest(
    String prompt,
    double temperature,
    int maxTokens,
  ) async {
    final apiKeyResult = _getApiKey();
    if (apiKeyResult.isLeft()) {
      return apiKeyResult;
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        GeminiConstants.apiEndpoint,
        queryParameters: {'key': apiKeyResult.getOrElse(() => '')},
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ],
            },
          ],
          'generationConfig': {
            'temperature': temperature,
            'maxOutputTokens': maxTokens,
          },
        },
      );

      if (response.statusCode == 200) {
        return _parseResponse(response.data);
      }

      return left(ServerFailure(errorMessage: 'API request failed'));
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }

  @override
  Future<Either<Failure, String>> generateKeywords(
    String content,
    String locale,
  ) async {
    final languageInstruction = _getLanguageInstruction(locale);
    final prompt = _buildPrompt(
      GeminiConstants.keywordsPrompt,
      languageInstruction,
      content,
    );

    final result = await _makeRequest(
      prompt,
      GeminiConstants.keywordsTemperature,
      GeminiConstants.keywordsMaxTokens,
    );

    return result.fold(
      (failure) => left(ServerFailure(errorMessage: StringConstants.geminiKeywordsGenerationFailed)),
      (response) => right(response),
    );
  }

  @override
  Future<Either<Failure, String>> generateSummary(
    String content,
    String locale,
  ) async {
    final languageInstruction = _getLanguageInstruction(locale);
    final prompt = _buildPrompt(
      GeminiConstants.summaryPrompt,
      languageInstruction,
      content,
    );

    final result = await _makeRequest(
      prompt,
      GeminiConstants.summaryTemperature,
      GeminiConstants.summaryMaxTokens,
    );

    return result.fold(
      (failure) => left(ServerFailure(errorMessage: StringConstants.geminiSummaryGenerationFailed)),
      (response) => right(response),
    );
  }
}
