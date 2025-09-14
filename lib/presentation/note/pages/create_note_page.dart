import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/init/di_container.dart';
import 'package:flutter_note_app/core/utils/size/constant_size.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';
import 'package:flutter_note_app/presentation/note/bloc/note_cubit.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';
import 'package:flutter_note_app/shared/widgets/custom_button.dart';

/// Simple and clean note creation page
class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isFavorite = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        createNoteUseCase: getIt<CreateNoteUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yeni Not'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<NoteCubit, NoteState>(
          listener: (context, state) {
            if (state is NoteFailure) {
              CustomSnackBar.showError(context, state.message);
            }
            if (state is NoteSuccess) {
              CustomSnackBar.showSuccess(context, 'Not başarıyla oluşturuldu!');
              context.pop(); // Return to previous page
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is NoteLoading,
              child: Padding(
                padding: EdgeInsets.all(context.cMediumValue),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title input
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Başlık',
                          hintText: 'Not başlığını girin...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Başlık gereklidir';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),

                      SizedBox(height: context.cMediumValue),

                      // Content input
                      Expanded(
                        child: TextFormField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            labelText: 'İçerik',
                            hintText: 'Not içeriğini girin...',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'İçerik gereklidir';
                            }
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          textInputAction: TextInputAction.newline,
                        ),
                      ),

                      SizedBox(height: context.cMediumValue),

                      // Favorite checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _isFavorite,
                            onChanged: (value) {
                              setState(() {
                                _isFavorite = value ?? false;
                              });
                            },
                          ),
                          const Text('Favorilere ekle'),
                          const Spacer(),
                          if (_isFavorite)
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                        ],
                      ),

                      SizedBox(height: context.cMediumValue),

                      // Create button
                      CustomButtonWidget(
                        onPressed: () => _createNote(context),
                        text: 'Not Oluştur',
                        isRequestAvaliable: state is NoteLoading,
                      ),

                      SizedBox(height: context.cSmallValue),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _createNote(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<NoteCubit>().createNote(
            title: _titleController.text,
            content: _contentController.text,
            isFavorite: _isFavorite,
          );
    }
  }
}
