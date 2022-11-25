import 'package:get/get.dart';

validator(String value, int min, int max, String type) {
  // chekc if entred value is a username
  if (type == 'username') {
    if (!GetUtils.isUsername(value)) {
      return "User Name too long";
    }
  }
  // chekc if entred value is a email
  if (type == 'email') {
    if (!GetUtils.isEmail(value)) {
      return "email not valid";
    }
  }
  // check if entred value is empty
  if (value.isEmpty) {
    return 'cant be empty';
  }
  // check if entred value is less than min
  if (value.length < min) {
    return 'cant be less than $min';
  }
  // check if entred value is less than max
  if (value.length > max) {
    return 'cant be less than $max';
  }
}
