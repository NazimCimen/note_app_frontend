enum ImageEnums {
  logo,

  forget_password,
  refresh_password,

  flag_turkiye,
  flag_usa,
 

  ic_email,
  ic_password,
  ic_google,
  ic_facebook,
  ic_nameSurname,
}

extension AssetExtension on ImageEnums {
  String get toPathPng => 'assets/images/$name.png';
}
