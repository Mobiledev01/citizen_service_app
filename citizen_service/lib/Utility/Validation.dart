bool validEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

bool onlyTextWithSpace(String value) {
  return RegExp(r'^[a-zA-Z ]*$').hasMatch(value);
}

bool onlyDigit(String value) {
  return RegExp(r'^[0-9]*$').hasMatch(value);
}

bool onlyNumberWithPoint(String value) {
  return RegExp(r'^[0-9.]*$').hasMatch(value);
}

bool textWithOutSpace(String value) {
  return RegExp(r'^[a-zA-Z\t]*$').hasMatch(value);
}

bool textareaWithoutSpecialCharacter(String value) {
  return RegExp(r'^[a-z(?\-.) A-Z(?\-.) 0-9(?\-.)]*$').hasMatch(value);
}

bool password(String value) {
  return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value);
}

bool mobile(String value) {
  return RegExp(r'^([6-9]{1}[0-9]{9})?$').hasMatch(value);
}

bool payScale(String value) {
  return RegExp(r'^[0-9]{1,6}(-)[0-9]{1,6}?$').hasMatch(value);
}

bool alphaNumeric(String value) {
  return RegExp(r'^[a-zA-Z0-9 ]*$').hasMatch(value);
}

bool isValidYear(String value) {
  return RegExp(r'^([2][0-9]{3}[-][0-9]{4})*$').hasMatch(value);
}

bool isValidPincode(String value) {
  return RegExp(r'^([0-9]{6})?$').hasMatch(value);
}

bool floatValue(String value) {
  return RegExp(r'^([0-9]{2}(\.))?([0-9]{2})?$').hasMatch(value);
}

bool simpleText(String value) {
  return RegExp(r'^[a-zA-Z ]*$').hasMatch(value);
}

bool comaSingleQuoteText(String value) {
  return RegExp(r"^[,,/']*$").hasMatch(value);
}
