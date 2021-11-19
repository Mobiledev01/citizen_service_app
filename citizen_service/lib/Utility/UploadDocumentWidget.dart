import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentWidget extends StatelessWidget {
  Function selectValue;
  String lable;
  String flag;

  UploadDocumentWidget(
      {required this.flag, required this.lable, required this.selectValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
              child: ElevatedButton(
                style: uploadButtonBlueStyle,
                onPressed: () {
                  chooseFile(context, flag);
                },
                child: Icon(
                  Icons.attach_file_outlined,
                  size: 25,
                  color: whiteColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              lable,
              style: grayNormalText14,
            ),
          )
        ],
      ),
    );
  }

  chooseFile(BuildContext context, String flag) {
    // flag I :- only image picker P:- Pdf picker A:- Both file picker

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: flag == "I"
                ? 150
                : flag == "P"
                    ? 100
                    : 200,
            margin: EdgeInsets.only(bottom: 0, left: 2, right: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                        )),
                  ),
                ),
                flag == 'I' || flag == 'A' || flag.isEmpty
                    ? TextButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);
                          showCamera();
                        },
                        child: Text(
                          choose_camera,
                          style: whiteBoldText14,
                        ),
                      )
                    : SizedBox(),
                flag == 'I' || flag == 'A' || flag.isEmpty
                    ? TextButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);
                          openGallery();
                        },
                        child: Text(
                          choose_from_gallery,
                          style: whiteBoldText14,
                        ),
                      )
                    : SizedBox(),
                flag == 'P' || flag == 'A' || flag.isEmpty
                    ? TextButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);
                          openPdfChoose();
                        },
                        child: Text(
                          choose_file_t,
                          style: whiteBoldText14,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  openGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // Uint8List? fileBytes = result.files.first.bytes;
      // print(file.name);
      // // print(fileBytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      selectValue(file, 'I');
    } else {
      showMessageToast('No Any File Select');
    }
  }

  openPdfChoose() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      double size = (file.size/1024).floorToDouble();

      if(size < 500){
        selectValue(file, 'P');
      }else{
        showErrorToast('File size must be less than 500 Kb');
      }

      // Uint8List? fileBytes = result.files.first.bytes;
      // print(file.name);
      // // print(fileBytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);

    } else {
      showMessageToast('No Any File Select');
    }
  }

  Future showCamera() async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    selectValue(image, 'C');
  }
}
