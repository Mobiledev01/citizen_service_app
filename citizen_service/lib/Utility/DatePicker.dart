import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Style.dart';

class DateChoser extends StatefulWidget {

   DateTime printdate;
   Function selectval;
   String text;

   DateChoser(this.printdate,this.selectval,this.text);


  @override
  State<StatefulWidget> createState() {
    return _DateChoserState();
  }
}

class _DateChoserState extends State<DateChoser> {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () async {
              DateTime? selected = await showDatePicker(
                context: context,
                initialDate: widget.printdate,
                firstDate: DateTime(2010),
                lastDate: DateTime(2025),
              );
              if (selected != null && selected != widget.printdate)
              {
                widget.selectval(selected);
                setState(() {
                    widget.text = formatter.format(selected).toString();
                });

              }
            },
            child: Text(
            widget.text,
              style: grayNormalText14,
            ),
          ),
        ));
  }
}
