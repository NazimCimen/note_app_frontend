import 'package:equatable/equatable.dart';

/// Parameters for login use case
class AuthParams extends Equatable {
  const AuthParams({this.email, this.password, this.fullName});

  final String? email;
  final String? password;
  final String? fullName;
  @override
  List<Object?> get props => [email, password, fullName];
}

/// Parameters for create note use case
class CreateNoteParams extends Equatable {
  const CreateNoteParams({
    required this.title,
    required this.content,
    this.isFavorite = false,
  });

  final String title;
  final String content;
  final bool isFavorite;

  @override
  List<Object> get props => [title, content, isFavorite];
}
