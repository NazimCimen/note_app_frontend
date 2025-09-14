import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'dart:io';

class ImageUtils {
  static Future<Either<Failure, File>> pickAndCropImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int quality = 90,
    CropAspectRatio? aspectRatio,
    String? toolbarTitle,
    String? doneButtonTitle,
    String? cancelButtonTitle,
  }) async {
    try {
      // Pick image
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: maxWidth ?? 1024,
        maxHeight: maxHeight ?? 1024,
        imageQuality: quality,
      );

      if (image == null) {
        return Left(ImagePickerFailure(errorMessage: 'Resim seçilmedi'));
      }

      // Crop image
      final croppedImage = await _cropImage(
        imagePath: image.path,
        aspectRatio: aspectRatio,
        toolbarTitle: toolbarTitle,
        doneButtonTitle: doneButtonTitle,
        cancelButtonTitle: cancelButtonTitle,
      );

      if (croppedImage == null) {
        return Left(ImagePickerFailure(errorMessage: 'Resim kırpılamadı'));
      }

      return Right(File(croppedImage.path));
    } catch (e) {
      return Left(ImagePickerFailure(errorMessage: 'Resim seçilirken hata oluştu: $e'));
    }
  }

  static Future<CroppedFile?> _cropImage({
    required String imagePath,
    CropAspectRatio? aspectRatio,
    String? toolbarTitle,
    String? doneButtonTitle,
    String? cancelButtonTitle,
  }) async {
    try {
      return await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: aspectRatio ?? const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: toolbarTitle ?? 'Resim Düzenle',
            toolbarColor: Colors.black87,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            statusBarColor: Colors.black87,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
            showCropGrid: false,
            activeControlsWidgetColor: Colors.white,
            dimmedLayerColor: Colors.black.withOpacity(0.7),
            cropFrameColor: Colors.white,
            cropFrameStrokeWidth: 2,
          ),
          IOSUiSettings(
            title: toolbarTitle ?? 'Resim Düzenle',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            resetAspectRatioEnabled: false,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
            doneButtonTitle: doneButtonTitle ?? 'Kaydet',
            cancelButtonTitle: cancelButtonTitle ?? 'İptal',
            aspectRatioPresets: [CropAspectRatioPreset.square],
            minimumAspectRatio: 1.0,
          ),
        ],
      );
    } catch (e) {
      print('Image cropper error: $e');
      return null;
    }
  }

  // Convenience method for logo selection
  static Future<Either<Failure, File>> pickAndCropLogo() async {
    return pickAndCropImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      quality: 90,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      toolbarTitle: 'Logo Seç',
      doneButtonTitle: 'Kaydet',
      cancelButtonTitle: 'İptal',
    );
  }
}
