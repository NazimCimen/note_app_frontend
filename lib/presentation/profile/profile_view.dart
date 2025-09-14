import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/core/utils/auth_utils.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';
import 'package:flutter_note_app/shared/widgets/custom_button.dart';  
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = false;

  // Mock user data - replace with actual user data from your state management
  UserEntity _user = UserEntity(
    id: '1',
    email: 'user@example.com',
    username: 'John Doe',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    _usernameController.text = _user.username ?? '';
    _emailController.text = _user.email;
  }

  Future<void> _saveProfile() async {
    if (!_isEditing) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 1));
      
      // Update user data
      _user = _user.copyWith(
        username: _usernameController.text,
        email: _emailController.text,
        updatedAt: DateTime.now(),
      );

      setState(() {
        _isEditing = false;
        _isLoading = false;
      });

      CustomSnackBar.showSuccess(context, 'Profil başarıyla güncellendi!');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      CustomSnackBar.showError(context, 'Profil güncellenirken hata oluştu');
    }
  }

  void _cancelEdit() {
    _loadUserData();
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Bar
        AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title:  Text(
            'Profil',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            if (_isEditing)
              TextButton(
                onPressed: _cancelEdit,
                child: Text(
                  'İptal',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.noteSubtext,
                  ),
                ),
              )
            else
              TextButton(
                onPressed: () => setState(() => _isEditing = true),
                child: Text(
                  'Düzenle',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        
        // Profile Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Profile Avatar
                _buildProfileAvatar(),
                
                SizedBox(height: 24.h),
                
                // User Information
                _buildUserInfo(),
                
                SizedBox(height: 24.h),
                
                // Quick Stats
                _buildQuickStats(),
                
                SizedBox(height: 24.h),
                
                // Settings Menu
                _buildSettingsMenu(),
                
                SizedBox(height: 32.h),
                
                // Logout Button
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColorSoft,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _user.username?.isNotEmpty == true 
              ? _user.username![0].toUpperCase()
              : 'U',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        children: [
          // Username Field
          _buildInfoField(
            label: 'Kullanıcı Adı',
            controller: _usernameController,
            icon: Icons.person_outline,
            enabled: _isEditing,
          ),
          
          SizedBox(height: 16.h),
          
          // Email Field
          _buildInfoField(
            label: 'E-posta',
            controller: _emailController,
            icon: Icons.email_outlined,
            enabled: _isEditing,
          ),
          
          if (_isEditing) ...[
            SizedBox(height: 20.h),
            CustomButtonWidget(
              onPressed:(){},
              text: _isLoading ? 'Kaydediliyor...' : 'Değişiklikleri Kaydet',
              isRequestAvaliable: _isLoading,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.noteText,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: enabled ? AppColors.searchBackground : AppColors.searchBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: enabled ? AppColors.searchBorder : AppColors.searchBorder.withOpacity(0.5),
            ),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'EuclidCircularA',
              color: enabled ? AppColors.noteText : AppColors.noteSubtext,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20.w,
                color: enabled ? AppColors.noteSubtext : AppColors.noteSubtext.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.note_outlined,
              label: 'Notlar',
              value: '12',
            ),
          ),
          Container(
            width: 1,
            height: 40.h,
            color: AppColors.profileDivider,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.favorite_outline,
              label: 'Favoriler',
              value: '5',
            ),
          ),
          Container(
            width: 1,
            height: 40.h,
            color: AppColors.profileDivider,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.calendar_today_outlined,
              label: 'Gün',
              value: '30',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.w,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.noteText,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: AppColors.noteSubtext,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    return Container(
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
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Bildirimler',
            onTap: () {
              CustomSnackBar.showInfo(context, 'Bildirim ayarları yakında!');
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.security_outlined,
            title: 'Gizlilik',
            onTap: () {
              CustomSnackBar.showInfo(context, 'Gizlilik ayarları yakında!');
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Yardım',
            onTap: () {
              CustomSnackBar.showInfo(context, 'Yardım bölümü yakında!');
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: 'Hakkında',
            onTap: () {
              CustomSnackBar.showInfo(context, 'Uygulama bilgileri yakında!');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 20.w,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.noteText,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: AppColors.noteSubtext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 1,
      color: AppColors.profileDivider,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.errorColor.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showLogoutDialog,
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  size: 20.w,
                  color: AppColors.errorColor,
                ),
                SizedBox(width: 8.w),
                  Text(
                  'Çıkış Yap',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.errorColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Çıkış Yap',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.noteText,
          ),
        ),
        content: Text(
          'Hesabınızdan çıkmak istediğinizden emin misiniz?',
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
              AuthUtils.clearJwtToken();
              context.go('/login');
            },
            child: Text(
              'Çıkış Yap',
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
}