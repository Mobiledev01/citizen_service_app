import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  String? selValue;
  Function selectValue;
  List<DropDownModal> list = [];
  String lable;

  DropDownWidget(
      {required this.lable,
      required this.list,
      this.selValue,
      required this.selectValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(lable),

      isDense: true,
      value:  selValue != '' ? selValue : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value == null ? 'Please '+lable : null,
      onChanged: (String? value) async {
        if (selValue == '' || (value! != selValue)) {
          selectValue(value);
        }
      },
      isExpanded: true,
      items: list.map((DropDownModal user) {
        return DropdownMenuItem<String>(
            value: user.id,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                user.title,
                maxLines: null,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ));
      }).toList(),
    );
  }
}
