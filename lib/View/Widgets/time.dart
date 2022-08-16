import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:randolina/View/Screens/Home/Screens/Events/addIvent.dart';
import '../Screens/Home/Screens/Events/widget.dart';
// ...
import 'package:intl/intl.dart';

class BasicDateTimeField extends StatelessWidget {
  final type;
  final format = DateFormat("E, d MMM yyyy HH:mm:ss");
  final format2 = DateFormat("MMM d, h:mm a");

            late var     datefinal;

   BasicDateTimeField({super.key, required this.type});
DateTime? timeivnt;
  
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[SizedBox(height: 20,),
      buttonselcat(title:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: DateTimeField(
            format : format,
            onShowPicker : (context, currentValue) async {
             DateTime?  date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));

              if (date != null) {
              TimeOfDay?   time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                String datatime=format2.format(date.add(Duration(hours:time!.hour , minutes:time.minute ))); 
                datefinal=datatime.toString();
                if (type=="Départ") {
                  datedubte=datefinal;
                 datedubteiventt=  date.add(Duration(hours:time.hour , minutes:time.minute ));
                print(datedubteiventt.toString());

                }else{
                  datefine=datefinal;
                }
               Get.snackbar("Date", datedubteiventt.toString());
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
          ),
      ),
      ),
     ]);
  }


 
}
