import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  bool _isFavorite = false;
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasUnsavedChanges =
          _titleController.text.isNotEmpty ||
          _contentController.text.isNotEmpty;
    });
  }

  Future<void> _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      CustomSnackBar.showError(context, 'Lütfen not başlığı girin');
      _titleFocusNode.requestFocus();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
        _hasUnsavedChanges = false;
      });

      CustomSnackBar.showSuccess(context, 'Not başarıyla kaydedildi!');
      context.pop();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      CustomSnackBar.showError(context, 'Not kaydedilirken hata oluştu');
    }
  }

  void _showExitDialog() {
    if (!_hasUnsavedChanges) {
      context.pop();
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Kaydedilmemiş Değişiklikler',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.noteText,
          ),
        ),
        content: Text(
          'Kaydedilmemiş değişiklikleriniz var. Çıkmak istediğinizden emin misiniz?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.noteSubtext,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'İptal',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: AppColors.noteSubtext,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: Text(
              'Çık',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Yeni Not',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.noteText,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.w,
            color: AppColors.noteText,
          ),
          onPressed: _showExitDialog,
        ),
        actions: [
          // Favorite Toggle
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 24.w,
              color: _isFavorite
                  ? AppColors.favoriteColor
                  : AppColors.noteSubtext,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
          // Save Button
          TextButton(
            onPressed: _isLoading ? null : _saveNote,
            child: Text(
              _isLoading ? 'Kaydediliyor...' : 'Kaydet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
                color: _isLoading
                    ? AppColors.noteSubtext
                    : AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Title Input
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.cardBorder),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 4,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: TextField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'EuclidCircularA',
                  color: AppColors.noteText,
                ),
                decoration: InputDecoration(
                  hintText: 'Not başlığı...',
                  hintStyle: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.noteSubtext,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLines: 2,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => _contentFocusNode.requestFocus(),
              ),
            ),

            SizedBox(height: 16.h),

            // Content Input
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 4,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'EuclidCircularA',
                    color: AppColors.noteText,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Notunuzu buraya yazın...',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.noteSubtext,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Auto-save indicator
            if (_hasUnsavedChanges)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.warningColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.warningColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, size: 16.w, color: AppColors.warningColor),
                    SizedBox(width: 6.w),
                    Text(
                      'Kaydedilmemiş değişiklikler',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
