import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:safecty/feature/inspection_image/inspection_image_view_model.dart';
import 'package:safecty/feature/inspection_person/inspection_person_view_model.dart';
import 'package:safecty/feature/inspection_person/widget/inspection_person_card.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/color_button.dart';
import 'package:safecty/widgets/drop_dow_inspection.dart';
import 'package:safecty/widgets/loading_widget.dart';
import 'package:safecty/widgets/scafold_widget.dart';
import 'package:safecty/widgets/snackbar.dart';
import 'package:signature/signature.dart';

class InspectionPersonScreen extends StatefulWidget {
  const InspectionPersonScreen({super.key});

  @override
  _InspectionPersonScreenState createState() => _InspectionPersonScreenState();
}

class _InspectionPersonScreenState extends State<InspectionPersonScreen> {
  int _selectedIndex = 2;
  String? valuePerson;
  List<InspectionPerson> selectedPersons = [];
  List<bool>? isCheckList;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionPersonViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getPerson();
        await viewModel.getParameters();
        await viewModel.getPersonsSelect();
        if (viewModel.state == InspectionPersonViewState.completed) {
          selectedPersons = viewModel.selectPersons!;
          bool isCheckYeslist = viewModel.listParameters!
              .any((element) => element.isCheck == false);

          isCheckList = List.generate(
            viewModel.listParameters!.length,
            (index) => isCheckYeslist,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<InspectionPersonViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == InspectionPersonViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionPersonViewState.error) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBarWidget(
                message: "Error, volver a cargar la aplicación",
              ).build(context));
            },
          );
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionPersonViewState.completed) {
          return ScaffoldWidget(
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              value.savedPerson(selectedPersons);
              final viewModel = context.read<InspectionImageViewModel>();
              viewModel.init();
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(Spacing.medium),
              child: Column(
                children: [
                  Material(
                    elevation: 2.0,
                    child: Container(
                      color: AppColors.whiteBone,
                      width: size.width,
                      height: size.height * 0.13,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 80.0,
                            height: 80.0,
                            child: const CircleAvatar(
                              backgroundColor: AppColors.transparent,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 40.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.small),
                          Expanded(
                            child: DropDowInspection(
                              label: 'persona',
                              hinText: 'Buscar persona',
                              data: value.personDropDownType,
                              value: valuePerson,
                              onChange: (selectedValue) {
                                final selectedPerson = value.listPerson!
                                    .firstWhere((person) =>
                                        person.personId.toString() ==
                                        selectedValue);
                                setState(() {
                                  selectedPersons.add(selectedPerson);
                                  valuePerson = selectedValue;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: Spacing.small),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedPersons.length,
                      itemBuilder: (context, index) {
                        return InspectionPersonCard(
                          isActive: isCheckList![index],
                          inspectionPerson: selectedPersons[index],
                          onEdit: () => _openSignatureModal(
                            context,
                            selectedPersons[index],
                            size,
                          ),
                          onDelete: () =>
                              setState(() => selectedPersons.removeAt(index)),
                          onView: () => _viewSignature(
                              context, selectedPersons[index], size),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return LoadingWidget(
          height: size.height,
          width: size.width,
        );
      },
    );
  }

  void _viewSignature(
    BuildContext context,
    InspectionPerson person,
    Size size,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firma'),
          contentPadding: const EdgeInsets.all(Spacing.small),
          content: SizedBox(
            width: size.width * 0.6,
            height: size.height * 0.55,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(person.file!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    MyElevatedButton(
                      width: size.width * 0.6,
                      height: 50.0,
                      onPressed: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.orange[200]!, Colors.orange[800]!],
                      ),
                      child: const Text(
                        'Salir',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _openSignatureModal(
    BuildContext context,
    InspectionPerson person,
    Size size,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firma'),
          contentPadding: const EdgeInsets.all(Spacing.small),
          content: SizedBox(
            width: size.width * 0.6,
            height: size.height * 0.55,
            child: Column(
              children: [
                Signature(
                  controller: _controller,
                  height: size.height * 0.45,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: IconButton(
                        onPressed: () => _controller.clear(),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        iconSize: 30.0,
                        splashRadius: 25.0,
                        tooltip: 'Eliminar',
                      ),
                    ),
                    const SizedBox(width: Spacing.small),
                    MyElevatedButton(
                      width: size.width * 0.5,
                      height: 50.0,
                      onPressed: () async {
                        final data = await _controller.toPngBytes();
                        String fileName = 'example.jpg';
                        File cachedFile =
                            await saveUint8ListToCache(data!, fileName);
                        savedSignaturePerson(person, cachedFile);
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.orange[200]!, Colors.orange[800]!],
                      ),
                      child: Text(
                        AppLocalizations.of(context).send,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void savedSignaturePerson(
    InspectionPerson inspectionPerson,
    File signature,
  ) {
    inspectionPerson.file = signature;
    int indexToUpdate = selectedPersons
        .indexWhere((person) => person.personId == inspectionPerson.personId);

    if (indexToUpdate != -1) {
      setState(() => selectedPersons[indexToUpdate] = inspectionPerson);
    } else {
      print('La persona no se encuentra en la lista.');
    }
  }
}

Future<File> saveUint8ListToCache(Uint8List uint8List, String fileName) async {
  final cacheDirectory = await getTemporaryDirectory();

  final filePath = '${cacheDirectory.path}/$fileName';
  final file = File(filePath);
  await file.writeAsBytes(uint8List);
  return file;
}
