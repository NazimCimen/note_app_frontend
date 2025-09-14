import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/data/models/user_model.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Centralized AuthException handling logic based on Supabase official documentation
class AuthErrorHandler {
  /// Handle AuthException for login operations
  static Either<Failure, void> handleLoginAuthException(AuthException e) {
    switch (e.code) {
      // Email doğrulama hatası - kullanıcının giriş yapmasına izin ver
      case 'email_not_confirmed':
      case 'phone_not_confirmed':
        return right(null);
      
      // Kimlik doğrulama hataları
      case 'invalid_credentials':
        return left(AuthFailure(errorMessage: StringConstants.errorInvalidCredentials));
      case 'user_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorUserNotFound));
      case 'user_banned':
        return left(AuthFailure(errorMessage: StringConstants.errorUserBanned));
      case 'user_already_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorUserAlreadyExists));
      
      // Rate limiting hataları
      case 'over_request_rate_limit':
      case 'too_many_requests':
        return left(AuthFailure(errorMessage: StringConstants.errorTooManyRequests));
      case 'over_email_send_rate_limit':
        return left(AuthFailure(errorMessage: StringConstants.errorOverEmailSendRateLimit));
      case 'over_sms_send_rate_limit':
        return left(AuthFailure(errorMessage: StringConstants.errorOverSmsSendRateLimit));
      
      // E-posta hataları
      case 'email_address_invalid':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailAddressInvalid));
      case 'email_address_not_authorized':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailAddressNotAuthorized));
      case 'email_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailExists));
      
      // Telefon hataları
      case 'phone_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorPhoneExists));
      
      // OTP hataları
      case 'otp_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorOtpDisabled));
      case 'otp_expired':
        return left(AuthFailure(errorMessage: StringConstants.errorOtpExpired));
      
      // MFA hataları
      case 'insufficient_aal':
        return left(AuthFailure(errorMessage: StringConstants.errorInsufficientAal));
      case 'mfa_challenge_expired':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaChallengeExpired));
      case 'mfa_verification_failed':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaVerificationFailed));
      case 'mfa_verification_rejected':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaVerificationRejected));
      
      // Session hataları
      case 'session_expired':
        return left(AuthFailure(errorMessage: StringConstants.errorSessionExpired));
      case 'session_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorSessionNotFound));
      case 'refresh_token_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorRefreshTokenNotFound));
      case 'refresh_token_already_used':
        return left(AuthFailure(errorMessage: StringConstants.errorRefreshTokenAlreadyUsed));
      
      // Provider hataları
      case 'provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorProviderDisabled));
      case 'email_provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailProviderDisabled));
      case 'phone_provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorPhoneProviderDisabled));
      case 'anonymous_provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorAnonymousProviderDisabled));
      
      // OAuth hataları
      case 'oauth_provider_not_supported':
        return left(AuthFailure(errorMessage: StringConstants.errorOauthProviderNotSupported));
      case 'bad_oauth_callback':
        return left(AuthFailure(errorMessage: StringConstants.errorBadOauthCallback));
      case 'bad_oauth_state':
        return left(AuthFailure(errorMessage: StringConstants.errorBadOauthState));
      case 'provider_email_needs_verification':
        return left(AuthFailure(errorMessage: StringConstants.errorProviderEmailNeedsVerification));
      
      // JWT hataları
      case 'bad_jwt':
        return left(AuthFailure(errorMessage: StringConstants.errorBadJwt));
      case 'no_authorization':
        return left(AuthFailure(errorMessage: StringConstants.errorNoAuthorization));
      case 'not_admin':
        return left(AuthFailure(errorMessage: StringConstants.errorNotAdmin));
      
      // Flow state hataları
      case 'flow_state_expired':
        return left(AuthFailure(errorMessage: StringConstants.errorFlowStateExpired));
      case 'flow_state_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorFlowStateNotFound));
      
      // CAPTCHA hataları
      case 'captcha_failed':
        return left(AuthFailure(errorMessage: StringConstants.errorCaptchaFailed));
      
      // Network ve timeout hataları
      case 'network_error':
      case 'request_timeout':
        return left(AuthFailure(errorMessage: StringConstants.errorNetworkError));
      
      // Conflict hataları
      case 'conflict':
        return left(AuthFailure(errorMessage: StringConstants.errorConflict));
      
      // Validation hataları
      case 'validation_failed':
        return left(AuthFailure(errorMessage: StringConstants.errorValidationFailed));
      
      // Beklenmeyen hatalar
      case 'unexpected_failure':
        return left(AuthFailure(errorMessage: StringConstants.errorUnexpectedFailure));
      
      default:
        return left(AuthFailure(errorMessage: e.message));
    }
  }

  /// Handle AuthException for signup operations
  static Either<Failure, UserModel> handleSignupAuthException(AuthException e) {
    switch (e.code) {
      // Şifre hataları
      case 'weak_password':
        return left(AuthFailure(errorMessage: StringConstants.errorWeakPassword));
      case 'same_password':
        return left(AuthFailure(errorMessage: StringConstants.errorSamePassword));
      
      // E-posta hataları
      case 'email_exists':
      case 'email_already_in_use':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailExists));
      case 'email_address_invalid':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailAddressInvalid));
      case 'email_address_not_authorized':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailAddressNotAuthorized));
      
      // Telefon hataları
      case 'phone_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorPhoneExists));
      
      // Kullanıcı hataları
      case 'user_already_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorUserAlreadyExists));
      
      // Rate limiting hataları
      case 'over_request_rate_limit':
      case 'too_many_requests':
        return left(AuthFailure(errorMessage: StringConstants.errorTooManyRequests));
      case 'over_email_send_rate_limit':
        return left(AuthFailure(errorMessage: StringConstants.errorOverEmailSendRateLimit));
      case 'over_sms_send_rate_limit':
        return left(AuthFailure(errorMessage: StringConstants.errorOverSmsSendRateLimit));
      
      // Provider hataları
      case 'signup_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorSignupDisabled));
      case 'email_provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorEmailProviderDisabled));
      case 'phone_provider_disabled':
        return left(AuthFailure(errorMessage: StringConstants.errorPhoneProviderDisabled));
      
      // Network ve timeout hataları
      case 'network_error':
      case 'request_timeout':
        return left(AuthFailure(errorMessage: StringConstants.errorNetworkError));
      
      // Validation hataları
      case 'validation_failed':
        return left(AuthFailure(errorMessage: StringConstants.errorValidationFailed));
      
      // Beklenmeyen hatalar
      case 'unexpected_failure':
        return left(AuthFailure(errorMessage: StringConstants.errorUnexpectedFailure));
      
      default:
        return left(AuthFailure(errorMessage: e.message));
    }
  }

  /// Handle AuthException for general operations (logout, password reset, etc.)
  static Either<Failure, void> handleGeneralAuthException(AuthException e) {
    switch (e.code) {
      // Rate limiting hataları
      case 'over_request_rate_limit':
      case 'too_many_requests':
        return left(AuthFailure(errorMessage: StringConstants.errorTooManyRequests));
      
      // Session hataları
      case 'session_expired':
        return left(AuthFailure(errorMessage: StringConstants.errorSessionExpired));
      case 'session_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorSessionNotFound));
      
      // JWT hataları
      case 'bad_jwt':
        return left(AuthFailure(errorMessage: StringConstants.errorBadJwt));
      case 'no_authorization':
        return left(AuthFailure(errorMessage: StringConstants.errorNoAuthorization));
      case 'not_admin':
        return left(AuthFailure(errorMessage: StringConstants.errorNotAdmin));
      
      // Network ve timeout hataları
      case 'network_error':
      case 'request_timeout':
        return left(AuthFailure(errorMessage: StringConstants.errorNetworkError));
      
      // Validation hataları
      case 'validation_failed':
        return left(AuthFailure(errorMessage: StringConstants.errorValidationFailed));
      
      // Beklenmeyen hatalar
      case 'unexpected_failure':
        return left(AuthFailure(errorMessage: StringConstants.errorUnexpectedFailure));
      
      default:
        return left(AuthFailure(errorMessage: e.message));
    }
  }

  /// Handle AuthException for password reset operations
  static Either<Failure, void> handlePasswordResetAuthException(AuthException e) {
    switch (e.code) {
      case 'reauthentication_needed':
        return left(AuthFailure(errorMessage: StringConstants.errorReauthenticationNeeded));
      case 'reauthentication_not_valid':
        return left(AuthFailure(errorMessage: StringConstants.errorReauthenticationNotValid));
      case 'same_password':
        return left(AuthFailure(errorMessage: StringConstants.errorSamePassword));
      case 'weak_password':
        return left(AuthFailure(errorMessage: StringConstants.errorWeakPassword));
      
      default:
        return handleGeneralAuthException(e);
    }
  }

  /// Handle AuthException for MFA operations
  static Either<Failure, void> handleMFAAuthException(AuthException e) {
    switch (e.code) {
      case 'mfa_factor_not_found':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaFactorNotFound));
      case 'mfa_factor_name_conflict':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaFactorNameConflict));
      case 'mfa_phone_enroll_not_enabled':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaPhoneEnrollNotEnabled));
      case 'mfa_totp_enroll_not_enabled':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaTotpEnrollNotEnabled));
      case 'mfa_web_authn_enroll_not_enabled':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaWebAuthnEnrollNotEnabled));
      case 'too_many_enrolled_mfa_factors':
        return left(AuthFailure(errorMessage: StringConstants.errorTooManyEnrolledMfaFactors));
      case 'mfa_verified_factor_exists':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaVerifiedFactorExists));
      case 'mfa_ip_address_mismatch':
        return left(AuthFailure(errorMessage: StringConstants.errorMfaIpAddressMismatch));
      
      default:
        return handleGeneralAuthException(e);
    }
  }
}
