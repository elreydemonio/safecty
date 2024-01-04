import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safecty/feature/inspection_image/widget/text_field_image.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/app_imagen.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/color_button.dart';

class InspectionImageDialog extends StatefulWidget {
  final ValueChanged<InspectionImage> onImageAdded;
  final InspectionImage? inspectionImage;

  const InspectionImageDialog({
    super.key,
    required this.onImageAdded,
    this.inspectionImage,
  });

  @override
  _InspectionImageDialogState createState() => _InspectionImageDialogState();
}

class _InspectionImageDialogState extends State<InspectionImageDialog> {
  File? _imageFile;
  bool _activarTexto = true;
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Verificar si inspectionImage no es nulo y actualizar el estado
    if (widget.inspectionImage != null) {
      _imageFile = widget.inspectionImage!.file;
      _textEditingController.text = widget.inspectionImage!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.whiteBone,
      content: Container(
        height: size.height * 0.6,
        padding: const EdgeInsets.all(Spacing.large),
        width: size.width * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final imageFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );

                  if (imageFile != null) {
                    setState(() {
                      _imageFile = File(imageFile.path);
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(AppImages.defaultImage),
                            fit: BoxFit.cover,
                          ),
                  ),
                  height: size.height * 0.23,
                ),
              ),
              Material(
                elevation: 2.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      MyCustomTextField(
                        required: _activarTexto,
                        textEditingController: _textEditingController,
                        validator: (value) {
                          if (_activarTexto &&
                              (value == null || value.isEmpty)) {
                            return 'Por favor, ingrese un texto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: _activarTexto,
                            onChanged: (value) {
                              setState(() {
                                _activarTexto = value!;
                              });
                            },
                          ),
                          const Text('Activar Texto'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.xLarge),
              MyElevatedButton(
                width: size.width * 0.9,
                height: 50.0,
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    if (_imageFile != null) {
                      final inspectionImage = InspectionImage(
                        _textEditingController.text,
                        _imageFile!,
                      );

                      widget.onImageAdded(inspectionImage);

                      Navigator.of(context).pop();
                    }
                  }
                },
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.orange[200]!, Colors.orange[800]!],
                ),
                child: const Text('SIGN IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
