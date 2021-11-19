import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  backgroundColor: primaryColor,
  padding: EdgeInsets.all(10),
  minimumSize: Size(280, 40),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);

final ButtonStyle squareButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  backgroundColor: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle squareButtonBlueStyle = TextButton.styleFrom(
  primary: primaryColor,
  backgroundColor: primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle submitButtonBlueStyle = TextButton.styleFrom(
  primary: greenColor,
  backgroundColor: greenColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle  previousButtonBlueStyle = TextButton.styleFrom(
  primary: deepOrangeAccentColor,
  backgroundColor: deepOrangeAccentColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle cancelButtonBlueStyle = TextButton.styleFrom(
  primary: primaryColor,
  backgroundColor: primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle uploadButtonBlueStyle = TextButton.styleFrom(
  primary: grayColor,
  backgroundColor: primaryColor,
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle downloadButtonBlueStyle = TextButton.styleFrom(
  primary: primaryColor,
  backgroundColor: primaryColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle previewButtonBlueStyle = TextButton.styleFrom(
  primary: brownColor,
  backgroundColor: brownColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle documentButtonBlueStyle = ElevatedButton.styleFrom(
  primary: primaryColor,
);

TextStyle style =
    TextStyle(fontSize: 24, color: primaryColor, fontWeight: FontWeight.bold);

// Black Normal Style
TextStyle blackNormalText14 = TextStyle(fontSize: 14, color: blackColor);

TextStyle blackNormalText16 = TextStyle(fontSize: 16, color: blackColor);

TextStyle blackNormalText18 = TextStyle(fontSize: 18, color: blackColor);

// Black Bold Style
TextStyle blackBoldText14 =
    TextStyle(fontSize: 14, color: blackColor, fontWeight: FontWeight.bold);

TextStyle blackBoldText16 =
    TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.bold);

TextStyle blackBoldText18 =
    TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold);

// White Normal Style
TextStyle whiteNormalText13 = TextStyle(fontSize: 13, color: whiteColor);

TextStyle whiteNormalText14 = TextStyle(fontSize: 14, color: whiteColor);

TextStyle whiteNormalText16 = TextStyle(fontSize: 16, color: whiteColor);

TextStyle whiteNormalText18 = TextStyle(fontSize: 18, color: whiteColor);

// White Bold Style
TextStyle whiteBoldText14 =
    TextStyle(fontSize: 14, color: whiteColor, fontWeight: FontWeight.bold);

TextStyle whiteBoldText16 =
    TextStyle(fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold);

TextStyle whiteBoldText18 =
    TextStyle(fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold);

// Gray Normal Style
TextStyle grayNormalText14 = TextStyle(fontSize: 14, color: Colors.grey[800]);

TextStyle grayNormalText16 = TextStyle(fontSize: 16, color: Colors.grey[800]);

TextStyle grayNormalText18 = TextStyle(fontSize: 18, color: Colors.grey[800]);

// Gray Bold Style
TextStyle grayBoldText14 = TextStyle(fontSize: 14, color: Colors.grey[800], fontWeight: FontWeight.bold);

TextStyle grayBoldText16 = TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.bold);

TextStyle grayBoldText18 = TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.bold);


//ALPITA START

final ButtonStyle pdfButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  elevation: 80,
  primary: progressColor,

  shape:RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0),
  ),

);

TextStyle formLabelStyle = TextStyle(fontSize: 14,color: primaryColor);
TextStyle dashboardLabelStyle = TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.bold);
TextStyle dashboardBoldText14 =TextStyle(fontSize: 14, color: blackColor, fontWeight: FontWeight.bold);

TextStyle formTitle = TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle formLabel = TextStyle(fontSize: 16, color: Colors.grey[800]);
TextStyle formLabelColor = TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold);


BoxDecoration previewBoxDecoration = BoxDecoration(
    color: whiteColor,
    border: Border.all(color: secondcolor), borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)));

EdgeInsets  previewContainerPadding = EdgeInsets.all(20);
TextStyle graypreviewText13 = TextStyle(fontSize: 13, color:Colors.grey[600]);
TextStyle previewBoldText18 = TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold);

final ButtonStyle imageViewButtonStyle = TextButton.styleFrom(
  primary: grayColor,
  backgroundColor: primaryColor,
  padding: EdgeInsets.all(3),

  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);
TextStyle primaryNormalText16 = TextStyle(fontSize: 16, color: primaryColor);
TextStyle redNormalText18 = TextStyle(fontSize: 18, color: Colors.red);
//ALPITA END

//NIL START
BoxDecoration inputContainerBoxDecoration = BoxDecoration(
    color: Colors.grey[300], borderRadius: BorderRadius.circular(5));

EdgeInsets inputContainerPadding = EdgeInsets.fromLTRB(15.0, 0, 0, 0);

//NIL END


//KASIM START



TextStyle star = TextStyle(color: redColor);


//OTP STYLE

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
    counterStyle: TextStyle(height: double.minPositive,),
    counterText: "",
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: Color(0xFF757575)),
  );
}

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

//KASIM END