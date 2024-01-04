import 'package:flutter/material.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/theme/app_colors.dart';

class InspectionImageItem extends StatelessWidget {
  final InspectionImage inspectionImage;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const InspectionImageItem({
    super.key,
    required this.inspectionImage,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whiteBone,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: onEdit,
              child: Container(
                width: size.width * 0.2,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: FileImage(inspectionImage.file),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit_square,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    inspectionImage.description == null
                        ? 'No hay'
                        : inspectionImage.description!,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
