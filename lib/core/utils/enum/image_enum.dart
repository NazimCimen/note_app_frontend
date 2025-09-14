enum ImageEnums {
  logo,
  onboard1,
  onboard2,
  onboard3,
  logo_dark,
  logo_orj,
  google_logo,
  auth_back,
  forget_password,
  refresh_password,

  flag_brazil,
  flag_turkiye,
  flag_japan,
  flag_south_korea,
  flag_china,
  flag_russia,
  flag_france,
  flag_usa,
  flag_germany,
  flag_italy,
  flag_spain,
  flag_saudi_arabia,

  ic_email,
  ic_password,
  ic_google,
  ic_facebook,
  ic_nameSurname,
}

extension AssetExtension on ImageEnums {
  String get toPathPng => 'assets/images/$name.png';
}
