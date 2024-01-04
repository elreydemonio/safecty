import 'dart:io';

import 'package:safecty/model/repository/model/inspection_person.dart';

class PersonSignature {
  PersonSignature({
    required this.person,
    this.signature,
  });

  final InspectionPerson person;
  final File? signature;
}
