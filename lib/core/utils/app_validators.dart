import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

@immutable
final class AppValidators {
  const AppValidators._();

  static const String emailRegExp =
      r'^[^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*|(\".+\")@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordRegExp =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const String nameRegExp = r'^[a-zA-ZığüşöçİĞÜŞÖÇ ]{2,50}$';
  static const String phoneRegExp = r'^[0-9]{10,15}$';
  static const String companyNameRegExp = r'^[a-zA-ZığüşöçİĞÜŞÖÇ0-9\s\-\.&]{2,100}$';

  /// Validates name and surname input with Turkish character support.
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.validationNameRequired;
    }
    if (!RegExp(nameRegExp).hasMatch(value)) {
      return StringConstants.validationNameInvalid;
    }
    return null;
  }

  /// Validates email address format using regex pattern.
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.validationEmailRequired;
    }
    if (!RegExp(emailRegExp).hasMatch(value)) {
      return StringConstants.validationEmailInvalid;
    }
    return null;
  }

  /// Validates password with minimum length requirement.
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.validationPasswordRequired;
    } else if (value.length < 6) {
      return StringConstants.validationPasswordMinLength;
    } else {
      return null;
    }
  }

  /// Validates phone number with basic numeric length constraints.
  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.validationPhoneRequired;
    }
    if (!RegExp(phoneRegExp).hasMatch(value)) {
      return StringConstants.validationPhoneInvalid;
    }
    return null;
  }

  /// Validates company name with Turkish character and business name support.
  static String? companyNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Firma adı gereklidir';
    }
    if (!RegExp(companyNameRegExp).hasMatch(value.trim())) {
      return 'Firma adı geçerli değil';
    }
    return null;
  }

  /// Validates optional email for company.
  static String? companyEmailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    if (!RegExp(emailRegExp).hasMatch(value.trim())) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  /// Validates optional phone for company.
  static String? companyPhoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional
    }
    if (!RegExp(phoneRegExp).hasMatch(value.trim())) {
      return 'Geçerli bir telefon numarası giriniz';
    }
    return null;
  }

  /// Validates optional address for company.
  static String? companyAddressValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Address is optional
    }
    if (value.trim().length < 10) {
      return 'Adres en az 10 karakter olmalıdır';
    }
    if (value.trim().length > 500) {
      return 'Adres en fazla 500 karakter olabilir';
    }
    return null;
  }

  /// Validates product name (required field).
  static String? productNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ürün adı boş olamaz';
    }
    if (value.trim().length < 2) {
      return 'Ürün adı en az 2 karakter olmalıdır';
    }
    if (value.trim().length > 100) {
      return 'Ürün adı en fazla 100 karakter olabilir';
    }
    return null;
  }

  /// Validates product description (optional field).
  static String? productDescriptionValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Description is optional
    }
    if (value.trim().length > 500) {
      return 'Ürün açıklaması en fazla 500 karakter olabilir';
    }
    return null;
  }

  /// Validates product price (required field).
  static String? productPriceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Fiyat boş olamaz';
    }
    
    // Remove currency symbol and whitespace
    final cleanValue = value.replaceAll(RegExp(r'[₺\s]'), '');
    
    if (cleanValue.isEmpty) {
      return 'Geçerli bir fiyat giriniz';
    }
    
    // Check if it's a valid number
    final price = double.tryParse(cleanValue);
    if (price == null) {
      return 'Geçerli bir fiyat giriniz';
    }
    
    if (price <= 0) {
      return 'Fiyat 0\'dan büyük olmalıdır';
    }
    
    if (price > 999999.99) {
      return 'Fiyat çok yüksek';
    }
    
    return null;
  }
}
