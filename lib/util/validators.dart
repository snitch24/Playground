import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

class TextFieldValidator {
  static String? name(String? name) {
    bool isNameValid = Fzregex.hasMatch(name!, FzPattern.name);
    if (name.isEmpty) {
      return 'Name can not be empty';
    }
    if (isNameValid == false) {
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  static String? email(String? mail) {
    bool isEmailValid = Fzregex.hasMatch(mail!, FzPattern.email);
     if (mail.isEmpty) {
      return 'Mail can not be empty';
    }
    if (isEmailValid == false) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }
}
