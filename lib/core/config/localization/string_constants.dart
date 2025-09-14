import 'package:flutter/material.dart';

@immutable
final class StringConstants {
  const StringConstants._();

  // App
  static String get appName => 'Smart Sell';
  static String get appTagline => 'Dakikalar içinde akıllı teklif oluşturun';
  static String get appDescription =>
      'Smart Sell; satış ekiplerinin müşteri seçimlerine göre otomatik, tutarlı ve hızlı fiyat teklifleri oluşturmasını sağlar. Firma bilgileri bir kez kaydedilir, her teklifte tekrar kullanılabilir. Çıktılar anında PDF olarak paylaşılabilir.';

  // Common
  static String get continueText => 'Devam Et';
  static String get cancel => 'Vazgeç';
  static String get ok => 'Tamam';

  // Auth - headers
  // Auth - contextual headers
  static String get authLoginTitle => 'Hoş geldiniz';
  static String get authLoginSubtitle =>
      'Hesabınıza giriş yapın ve tekliflerinizi yönetin';
  static String get authSignupTitle => 'Aramıza katılın';
  static String get authSignupSubtitle =>
      'Smart Sell ile dakikalar içinde akıllı teklif oluşturun';
  // Backward-friendly defaults (used if specific titles not provided)
  static String get welcomeTitle => authLoginTitle;
  static String get welcomeSubtitle => appTagline;

  // Auth - fields
  static String get fullName => 'Ad Soyad';
  static String get phoneNumber => 'Telefon numarası';
  static String get email => 'E-posta adresi';
  static String get password => 'Şifreniz';

  // Auth - actions
  static String get login => 'Giriş yap';
  static String get signup => 'Kayıt ol';
  static String get logout => 'Çıkış yap';

  // Auth - footers
  static String get dontHaveAccount => 'Hesabınız yok mu? ';
  static String get haveAccount => 'Zaten hesabınız var mı? ';
  static String get goToSignup => 'Kayıt ol';
  static String get goToLogin => 'Giriş yap';
  
  // Auth - loading messages
  static String get socialLoginLoadingMessage => 'Giriş yapılıyor...';

  // Feedback / Snackbars
  static String get loginSuccess => 'Hoş geldiniz!';
  static String get signupSuccess => 'Kayıt tamamlandı. Hemen başlayalım!';
  static String get invalidCredentials => 'Bilgilerinizi kontrol edip tekrar deneyin';
  static String get invalidSignupData => 'Lütfen tüm alanları kontrol edin';

  // Validation messages
  static String get validationNameRequired => 'Ad soyad gereklidir';
  static String get validationNameInvalid => 'Geçerli bir ad soyad girin';
  static String get validationEmailRequired => 'E-posta gereklidir';
  static String get validationEmailInvalid => 'Geçerli bir e-posta adresi girin';
  static String get validationPasswordRequired => 'Şifre gereklidir';
  static String get validationPasswordMinLength => 'Şifre en az 6 karakter olmalı';
  static String get validationPhoneRequired => 'Telefon numarası gereklidir';
  static String get validationPhoneInvalid => 'Geçerli bir telefon numarası giriniz';

  // PDF / Offer
  static String get createOffer => 'Teklif oluştur';
  static String get downloadPdf => 'PDF indir';
  static String get regenerate => 'Teklifi yenile';

  // Auth Error Messages
  // Login Errors
  static String get errorInvalidCredentials => 'E-posta veya şifre hatalı';
  static String get errorUserNotFound => 'Kullanıcı bulunamadı';
  static String get errorUserBanned => 'Hesabınız geçici olarak askıya alınmıştır';
  static String get errorUserAlreadyExists => 'Bu kullanıcı zaten mevcut';
  
  // Rate Limiting Errors
  static String get errorTooManyRequests => 'Çok fazla deneme yaptınız. Lütfen birkaç dakika bekleyin.';
  static String get errorOverEmailSendRateLimit => 'Çok fazla e-posta gönderildi. Lütfen bekleyin.';
  static String get errorOverSmsSendRateLimit => 'Çok fazla SMS gönderildi. Lütfen bekleyin.';
  
  // Email Errors
  static String get errorEmailAddressInvalid => 'Geçersiz e-posta adresi';
  static String get errorEmailAddressNotAuthorized => 'Bu e-posta adresi için yetkilendirme yok';
  static String get errorEmailExists => 'Bu e-posta adresi zaten kullanımda';
  
  // Phone Errors
  static String get errorPhoneExists => 'Bu telefon numarası zaten kullanımda';
  
  // OTP Errors
  static String get errorOtpDisabled => 'OTP girişi devre dışı';
  static String get errorOtpExpired => 'OTP kodunun süresi dolmuş';
  
  // MFA Errors
  static String get errorInsufficientAal => 'MFA doğrulaması gerekli';
  static String get errorMfaChallengeExpired => 'MFA doğrulama süresi dolmuş';
  static String get errorMfaVerificationFailed => 'MFA doğrulama başarısız';
  static String get errorMfaVerificationRejected => 'MFA doğrulama reddedildi';
  static String get errorMfaFactorNotFound => 'MFA faktörü bulunamadı';
  static String get errorMfaFactorNameConflict => 'MFA faktör adı çakışması';
  static String get errorMfaPhoneEnrollNotEnabled => 'Telefon MFA kaydı devre dışı';
  static String get errorMfaTotpEnrollNotEnabled => 'TOTP MFA kaydı devre dışı';
  static String get errorMfaWebAuthnEnrollNotEnabled => 'WebAuthn MFA kaydı devre dışı';
  static String get errorTooManyEnrolledMfaFactors => 'Çok fazla MFA faktörü kayıtlı';
  static String get errorMfaVerifiedFactorExists => 'Doğrulanmış telefon faktörü zaten mevcut';
  static String get errorMfaIpAddressMismatch => 'IP adresi uyumsuzluğu';
  
  // Session Errors
  static String get errorSessionExpired => 'Oturum süresi dolmuş. Lütfen tekrar giriş yapın.';
  static String get errorSessionNotFound => 'Oturum bulunamadı. Lütfen tekrar giriş yapın.';
  static String get errorRefreshTokenNotFound => 'Yenileme tokeni bulunamadı';
  static String get errorRefreshTokenAlreadyUsed => 'Yenileme tokeni zaten kullanılmış';
  
  // Provider Errors
  static String get errorProviderDisabled => 'Bu giriş yöntemi devre dışı';
  static String get errorEmailProviderDisabled => 'E-posta ile giriş devre dışı';
  static String get errorPhoneProviderDisabled => 'Telefon ile giriş devre dışı';
  static String get errorAnonymousProviderDisabled => 'Anonim giriş devre dışı';
  static String get errorSignupDisabled => 'Kayıt işlemi devre dışı';
  
  // OAuth Errors
  static String get errorOauthProviderNotSupported => 'Bu OAuth sağlayıcısı desteklenmiyor';
  static String get errorBadOauthCallback => 'OAuth callback hatası';
  static String get errorBadOauthState => 'OAuth state hatası';
  static String get errorProviderEmailNeedsVerification => 'OAuth e-posta doğrulaması gerekli';
  
  // JWT Errors
  static String get errorBadJwt => 'Geçersiz JWT token';
  static String get errorNoAuthorization => 'Yetkilendirme gerekli';
  static String get errorNotAdmin => 'Admin yetkisi gerekli';
  
  // Flow State Errors
  static String get errorFlowStateExpired => 'Giriş akışı süresi dolmuş. Lütfen tekrar deneyin.';
  static String get errorFlowStateNotFound => 'Giriş akışı bulunamadı. Lütfen tekrar deneyin.';
  
  // CAPTCHA Errors
  static String get errorCaptchaFailed => 'CAPTCHA doğrulaması başarısız';
  
  // Network and Timeout Errors
  static String get errorNetworkError => 'Ağ bağlantısı hatası. Lütfen tekrar deneyin.';
  static String get errorRequestTimeout => 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';
  
  // Conflict Errors
  static String get errorConflict => 'Çakışma hatası. Lütfen tekrar deneyin.';
  
  // Validation Errors
  static String get errorValidationFailed => 'Geçersiz veri formatı';
  
  // Password Errors
  static String get errorWeakPassword => 'Şifre çok zayıf. Daha güçlü bir şifre seçin.';
  static String get errorSamePassword => 'Yeni şifre mevcut şifre ile aynı olamaz';
  
  // Reauthentication Errors
  static String get errorReauthenticationNeeded => 'Şifre değiştirmek için yeniden kimlik doğrulama gerekli';
  static String get errorReauthenticationNotValid => 'Yeniden kimlik doğrulama başarısız';
  
  // Unexpected Errors
  static String get errorUnexpectedFailure => 'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.';

  // Note Operations
  static String get noteCreateFailed => 'Not oluşturulamadı';
  static String get noteGetFailed => 'Notlar getirilemedi';
  static String get noteNotFound => 'Not bulunamadı';
  static String get noteUpdateFailed => 'Not güncellenemedi';
  static String get noteDeleteFailed => 'Not silinemedi';

  // Dio Error Messages
  static String get dioConnectionTimeout => 'Bağlantı zaman aşımı';
  static String get dioAuthError => 'Yetkilendirme hatası - JWT token gerekli';
  static String get dioNotFound => 'API endpoint bulunamadı';
  static String get dioServerError => 'Sunucu hatası';
  static String get dioRequestCancelled => 'İstek iptal edildi';
  static String get dioConnectionError => 'API sunucusuna bağlanılamıyor';
  static String get dioUnknownError => 'Bilinmeyen hata';
  static String get dioUnexpectedError => 'Beklenmeyen hata';
  
  // HTTP Status Code Error Messages
  static String get httpBadRequest => 'Geçersiz istek';
  static String get httpForbidden => 'Bu işlem için yetkiniz yok';
  static String get httpConflict => 'Veri çakışması';
  static String get httpUnprocessableEntity => 'Geçersiz veri formatı';
  static String get httpTooManyRequests => 'Çok fazla istek gönderildi. Lütfen bekleyin.';
  static String get httpBadGateway => 'Sunucu geçici olarak kullanılamıyor';
  static String get httpServiceUnavailable => 'Sunucu bakımda';
  static String get httpGatewayTimeout => 'Sunucu yanıt vermiyor';

  // Time Utils
  static String get timeJustNow => 'Az önce';
  static String timeDaysAgo(int days) => '$days gün önce';
  static String timeHoursAgo(int hours) => '$hours saat önce';
  static String timeMinutesAgo(int minutes) => '$minutes dakika önce';
}
