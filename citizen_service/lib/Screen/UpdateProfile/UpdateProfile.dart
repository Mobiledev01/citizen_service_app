import 'package:citizen_service/Model/LoginSessionModel/LoginSessionModel.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {


  const EditProfilePage(
      {Key? key})
      : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  bool showPassword = false;
  late LoginSessionModel model;
  String fileName = '',filePath = '';

  @override
  void initState() {
    super.initState();
    model = globals.loginSessionModel! ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: blackColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () {
              showMessageToast('Save');
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 25, right: 20, bottom: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: grey.withOpacity(0.6),
                            offset: const Offset(2.0, 4.0),
                            blurRadius: 8),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(60.0)),
                      child: Image.asset('assets/userImage.png'),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          chooseFile(context, 'I');
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: primaryColor,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            buildTextField("Full Name", "Dor Alex", false),
            buildTextField("Mobile Number", model.mobileNo.toString(), false),
            buildTextField("E-mail", model.emailId.toString(), false),
            SizedBox(
              height: 35,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     OutlineButton(
            //       padding: EdgeInsets.symmetric(horizontal: 50),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20)),
            //       onPressed: () {
            //          Navigator.pop(context);
            //       },
            //       child: Text("CANCEL",
            //           style: TextStyle(
            //               fontSize: 14,
            //               letterSpacing: 2.2,
            //               color: Colors.black)),
            //     ),
            //     RaisedButton(
            //       onPressed: () {},
            //       color: primaryColor,
            //       padding: EdgeInsets.symmetric(horizontal: 50),
            //       elevation: 2,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20)),
            //       child: Text(
            //         "SAVE",
            //         style: TextStyle(
            //             fontSize: 14,
            //             letterSpacing: 2.2,
            //             color: Colors.white),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
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
      setState(() {
        fileName = file.name;
        filePath = file.path!;
      });
    } else {
      showMessageToast('No Any File Select');
    }
  }

  Future showCamera() async {
    ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      XFile file = image!;
      setState(() {
        fileName = file.name;
        filePath = file.path;
      });
  }
}
