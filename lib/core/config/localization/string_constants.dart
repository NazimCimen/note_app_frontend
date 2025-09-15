import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

@immutable
final class StringConstants {
  const StringConstants._();

  // App
  static String get appName => 'appName'.tr();
  static String get appTagline => 'appTagline'.tr();
  static String get appDescription => 'appDescription'.tr();

  // Common
  static String get continueText => 'continueText'.tr();
  static String get cancel => 'cancel'.tr();
  static String get ok => 'ok'.tr();

  // Auth - headers
  static String get authLoginTitle => 'authLoginTitle'.tr();
  static String get authLoginSubtitle => 'authLoginSubtitle'.tr();
  static String get authSignupTitle => 'authSignupTitle'.tr();
  static String get authSignupSubtitle => 'authSignupSubtitle'.tr();
  static String get welcomeTitle => authLoginTitle;
  static String get welcomeSubtitle => appTagline;

  // Auth - fields
  static String get fullName => 'fullName'.tr();
  static String get phoneNumber => 'phoneNumber'.tr();
  static String get email => 'email'.tr();
  static String get password => 'password'.tr();

  // Auth - actions
  static String get login => 'login'.tr();
  static String get signup => 'signup'.tr();
  static String get logout => 'logout'.tr();

  // Auth - footers
  static String get dontHaveAccount => 'dontHaveAccount'.tr();
  static String get haveAccount => 'haveAccount'.tr();
  static String get goToSignup => 'goToSignup'.tr();
  static String get goToLogin => 'goToLogin'.tr();
  
  // Auth - loading messages
  static String get socialLoginLoadingMessage => 'socialLoginLoadingMessage'.tr();

  // Feedback / Snackbars
  static String get loginSuccess => 'loginSuccess'.tr();
  static String get signupSuccess => 'signupSuccess'.tr();
  static String get invalidCredentials => 'invalidCredentials'.tr();
  static String get invalidSignupData => 'invalidSignupData'.tr();

  // Validation messages
  static String get validationNameRequired => 'validationNameRequired'.tr();
  static String get validationNameInvalid => 'validationNameInvalid'.tr();
  static String get validationEmailRequired => 'validationEmailRequired'.tr();
  static String get validationEmailInvalid => 'validationEmailInvalid'.tr();
  static String get validationPasswordRequired => 'validationPasswordRequired'.tr();
  static String get validationPasswordMinLength => 'validationPasswordMinLength'.tr();
  static String get validationPhoneRequired => 'validationPhoneRequired'.tr();
  static String get validationPhoneInvalid => 'validationPhoneInvalid'.tr();

  // Note Operations
  static String get createNote => 'createNote'.tr();
  static String get editNote => 'editNote'.tr();
  static String get saveNote => 'saveNote'.tr();
  static String get updateNote => 'updateNote'.tr();
  static String get deleteNote => 'deleteNote'.tr();
  static String get favoriteNote => 'favoriteNote'.tr();
  static String get unfavoriteNote => 'unfavoriteNote'.tr();

  // Auth Error Messages
  // Login Errors
  static String get errorInvalidCredentials => 'errorInvalidCredentials'.tr();
  static String get errorUserNotFound => 'errorUserNotFound'.tr();
  static String get errorUserBanned => 'errorUserBanned'.tr();
  static String get errorUserAlreadyExists => 'errorUserAlreadyExists'.tr();
  
  // Rate Limiting Errors
  static String get errorTooManyRequests => 'errorTooManyRequests'.tr();
  static String get errorOverEmailSendRateLimit => 'errorOverEmailSendRateLimit'.tr();
  static String get errorOverSmsSendRateLimit => 'errorOverSmsSendRateLimit'.tr();
  
  // Email Errors
  static String get errorEmailAddressInvalid => 'errorEmailAddressInvalid'.tr();
  static String get errorEmailAddressNotAuthorized => 'errorEmailAddressNotAuthorized'.tr();
  static String get errorEmailExists => 'errorEmailExists'.tr();
  
  // Phone Errors
  static String get errorPhoneExists => 'errorPhoneExists'.tr();
  
  // OTP Errors
  static String get errorOtpDisabled => 'errorOtpDisabled'.tr();
  static String get errorOtpExpired => 'errorOtpExpired'.tr();
  
  // MFA Errors
  static String get errorInsufficientAal => 'errorInsufficientAal'.tr();
  static String get errorMfaChallengeExpired => 'errorMfaChallengeExpired'.tr();
  static String get errorMfaVerificationFailed => 'errorMfaVerificationFailed'.tr();
  static String get errorMfaVerificationRejected => 'errorMfaVerificationRejected'.tr();
  static String get errorMfaFactorNotFound => 'errorMfaFactorNotFound'.tr();
  static String get errorMfaFactorNameConflict => 'errorMfaFactorNameConflict'.tr();
  static String get errorMfaPhoneEnrollNotEnabled => 'errorMfaPhoneEnrollNotEnabled'.tr();
  static String get errorMfaTotpEnrollNotEnabled => 'errorMfaTotpEnrollNotEnabled'.tr();
  static String get errorMfaWebAuthnEnrollNotEnabled => 'errorMfaWebAuthnEnrollNotEnabled'.tr();
  static String get errorTooManyEnrolledMfaFactors => 'errorTooManyEnrolledMfaFactors'.tr();
  static String get errorMfaVerifiedFactorExists => 'errorMfaVerifiedFactorExists'.tr();
  static String get errorMfaIpAddressMismatch => 'errorMfaIpAddressMismatch'.tr();
  
  // Session Errors
  static String get errorSessionExpired => 'errorSessionExpired'.tr();
  static String get errorSessionNotFound => 'errorSessionNotFound'.tr();
  static String get errorRefreshTokenNotFound => 'errorRefreshTokenNotFound'.tr();
  static String get errorRefreshTokenAlreadyUsed => 'errorRefreshTokenAlreadyUsed'.tr();
  
  // Provider Errors
  static String get errorProviderDisabled => 'errorProviderDisabled'.tr();
  static String get errorEmailProviderDisabled => 'errorEmailProviderDisabled'.tr();
  static String get errorPhoneProviderDisabled => 'errorPhoneProviderDisabled'.tr();
  static String get errorAnonymousProviderDisabled => 'errorAnonymousProviderDisabled'.tr();
  static String get errorSignupDisabled => 'errorSignupDisabled'.tr();
  
  // OAuth Errors
  static String get errorOauthProviderNotSupported => 'errorOauthProviderNotSupported'.tr();
  static String get errorBadOauthCallback => 'errorBadOauthCallback'.tr();
  static String get errorBadOauthState => 'errorBadOauthState'.tr();
  static String get errorProviderEmailNeedsVerification => 'errorProviderEmailNeedsVerification'.tr();
  
  // JWT Errors
  static String get errorBadJwt => 'errorBadJwt'.tr();
  static String get errorNoAuthorization => 'errorNoAuthorization'.tr();
  static String get errorNotAdmin => 'errorNotAdmin'.tr();
  
  // Flow State Errors
  static String get errorFlowStateExpired => 'errorFlowStateExpired'.tr();
  static String get errorFlowStateNotFound => 'errorFlowStateNotFound'.tr();
  
  // CAPTCHA Errors
  static String get errorCaptchaFailed => 'errorCaptchaFailed'.tr();
  
  // Network and Timeout Errors
  static String get errorNetworkError => 'errorNetworkError'.tr();
  static String get errorRequestTimeout => 'errorRequestTimeout'.tr();
  static String get errorNoInternetConnection => 'errorNoInternetConnection'.tr();
  
  // Conflict Errors
  static String get errorConflict => 'errorConflict'.tr();
  
  // Validation Errors
  static String get errorValidationFailed => 'errorValidationFailed'.tr();
  
  // Password Errors
  static String get errorWeakPassword => 'errorWeakPassword'.tr();
  static String get errorSamePassword => 'errorSamePassword'.tr();
  
  // Reauthentication Errors
  static String get errorReauthenticationNeeded => 'errorReauthenticationNeeded'.tr();
  static String get errorReauthenticationNotValid => 'errorReauthenticationNotValid'.tr();
  
  // Unexpected Errors
  static String get errorUnexpectedFailure => 'errorUnexpectedFailure'.tr();

  // Note Operations
  static String get noteCreateFailed => 'noteCreateFailed'.tr();
  static String get noteGetFailed => 'noteGetFailed'.tr();
  static String get noteNotFound => 'noteNotFound'.tr();
  static String get noteUpdateFailed => 'noteUpdateFailed'.tr();
  static String get noteDeleteFailed => 'noteDeleteFailed'.tr();
  static String get noteSaveSuccess => 'noteSaveSuccess'.tr();
  static String get noteUpdateSuccess => 'noteUpdateSuccess'.tr();
  static String get noteDeleteSuccess => 'noteDeleteSuccess'.tr();
  static String get noteUnsavedChanges => 'noteUnsavedChanges'.tr();
  static String get noteExitDialogTitle => 'noteExitDialogTitle'.tr();
  static String get noteExitDialogContent => 'noteExitDialogContent'.tr();
  static String get noteExitDialogCancel => 'noteExitDialogCancel'.tr();
  static String get noteExitDialogExit => 'noteExitDialogExit'.tr();
  static String get noteSaving => 'noteSaving'.tr();

  // Home Screen
  static String get homeTitle => 'homeTitle'.tr();
  static String get homeFilter => 'homeFilter'.tr();
  static String get homeSort => 'homeSort'.tr();
  static String get homeSearchHint => 'homeSearchHint'.tr();
  static String get homeSearchType => 'homeSearchType'.tr();
  static String get homeSearchTitle => 'homeSearchTitle'.tr();
  static String get homeSearchContent => 'homeSearchContent'.tr();
  static String get homeSearchBoth => 'homeSearchBoth'.tr();
  static String get homeFilterAll => 'homeFilterAll'.tr();
  static String get homeFilterFavorites => 'homeFilterFavorites'.tr();
  static String get homeSortNewest => 'homeSortNewest'.tr();
  static String get homeSortOldest => 'homeSortOldest'.tr();
  static String get homeRetryButton => 'homeRetryButton'.tr();
  static String get homeNoNotesTitle => 'homeNoNotesTitle'.tr();
  static String get homeNoNotesSubtitle => 'homeNoNotesSubtitle'.tr();
  static String get homeCreateFirstNote => 'homeCreateFirstNote'.tr();
  static String get homeErrorTitle => 'homeErrorTitle'.tr();
  static String get homeErrorSubtitle => 'homeErrorSubtitle'.tr();
  static String get homeRetryButtonText => 'homeRetryButtonText'.tr();

  // Profile Screen
  static String get profileTitle => 'profileTitle'.tr();
  static String get profileLogoutTitle => 'profileLogoutTitle'.tr();
  static String get profileLogoutContent => 'profileLogoutContent'.tr();
  static String get profileLogoutButton => 'profileLogoutButton'.tr();
  static String get profileError => 'profileError'.tr();
  static String get profileRetryButton => 'profileRetryButton'.tr();
  static String get profileUnknownState => 'profileUnknownState'.tr();
  static String get profileDefaultUsername => 'profileDefaultUsername'.tr();
  static String get profileLanguageTurkish => 'profileLanguageTurkish'.tr();
  static String get profileLanguageEnglish => 'profileLanguageEnglish'.tr();

  // Common UI
  static String get close => 'close'.tr();
  static String get retry => 'retry'.tr();
  static String get loading => 'loading'.tr();
  static String get language => 'language'.tr();
  
  // User Info
  static String get personalInfo => 'personalInfo'.tr();
  static String get username => 'username'.tr();
  
  // AI Operations
  static String get keywords => 'keywords'.tr();
  static String get textSummary => 'textSummary'.tr();
  static String get generating => 'generating'.tr();
  static String get generateKeywords => 'generateKeywords'.tr();
  static String get summarize => 'summarize'.tr();
  static String get keywordsHint => 'keywordsHint'.tr();
  static String get summaryHint => 'summaryHint'.tr();
  
  // Note Input
  static String get noteTitleHint => 'noteTitleHint'.tr();
  static String get noteContentHint => 'noteContentHint'.tr();
  
  // Theme Selection
  static String get theme => 'theme'.tr();
  static String get lightTheme => 'lightTheme'.tr();
  static String get darkTheme => 'darkTheme'.tr();

  // Gemini AI Operations
  static String get geminiApiKeyNotFound => 'geminiApiKeyNotFound'.tr();
  static String get geminiKeywordsGenerationFailed => 'geminiKeywordsGenerationFailed'.tr();
  static String get geminiSummaryGenerationFailed => 'geminiSummaryGenerationFailed'.tr();
  static String get geminiContentEmpty => 'geminiContentEmpty'.tr();
  static String get geminiContentTooShort => 'geminiContentTooShort'.tr();

  // Dio Error Messages
  static String get dioConnectionTimeout => 'dioConnectionTimeout'.tr();
  static String get dioAuthError => 'dioAuthError'.tr();
  static String get dioNotFound => 'dioNotFound'.tr();
  static String get dioServerError => 'dioServerError'.tr();
  static String get dioRequestCancelled => 'dioRequestCancelled'.tr();
  static String get dioConnectionError => 'dioConnectionError'.tr();
  static String get dioUnknownError => 'dioUnknownError'.tr();
  static String get dioUnexpectedError => 'dioUnexpectedError'.tr();
  
  // HTTP Status Code Error Messages
  static String get httpBadRequest => 'httpBadRequest'.tr();
  static String get httpForbidden => 'httpForbidden'.tr();
  static String get httpConflict => 'httpConflict'.tr();
  static String get httpUnprocessableEntity => 'httpUnprocessableEntity'.tr();
  static String get httpTooManyRequests => 'httpTooManyRequests'.tr();
  static String get httpBadGateway => 'httpBadGateway'.tr();
  static String get httpServiceUnavailable => 'httpServiceUnavailable'.tr();
  static String get httpGatewayTimeout => 'httpGatewayTimeout'.tr();

  // Time Utils
  static String get timeJustNow => 'timeJustNow'.tr();
  static String timeDaysAgo(int days) => 'timeDaysAgo'.tr(namedArgs: {'days': days.toString()});
  static String timeHoursAgo(int hours) => 'timeHoursAgo'.tr(namedArgs: {'hours': hours.toString()});
  static String timeMinutesAgo(int minutes) => 'timeMinutesAgo'.tr(namedArgs: {'minutes': minutes.toString()});
}
