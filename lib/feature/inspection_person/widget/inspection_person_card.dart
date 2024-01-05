import 'package:flutter/material.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class InspectionPersonCard extends StatelessWidget {
  const InspectionPersonCard({
    super.key,
    required this.inspectionPerson,
    required this.onDelete,
    required this.isActive,
    required this.onEdit,
    required this.onView,
  });

  final InspectionPerson inspectionPerson;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onView;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(Spacing.medium),
      child: Material(
        elevation: 2.0,
        child: Container(
          color: AppColors.whiteBone,
          height: size.height * 0.11,
          width: size.width,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 80.0,
                height: 80.0,
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.person_pin_circle_outlined,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: Spacing.small),
                    Text(
                      '${inspectionPerson.professionalName} ${inspectionPerson.professionalSurname}',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      inspectionPerson.identificationCard,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    isActive
                        ? inspectionPerson.file != null
                            ? IconButton(
                                icon: const Icon(Icons.image),
                                onPressed: onView,
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    isActive
                        ? IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: onEdit,
                          )
                        : const SizedBox(),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
