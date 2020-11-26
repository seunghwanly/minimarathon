// phone util
import 'package:libphonenumber/libphonenumber.dart';

//  //check members before payment
//   // available -> true
//   checkMembers() {
//     teamData.members.toList().asMap().forEach((index, element) {
//       if (index != 0 && element.name != null) {
//         // valid check
//         _isValidNumber(element.phoneNumber, "US").then((res) {
//           if (res) {
//             //noramlize number
//             _normalizePhonNumber(element.phoneNumber, "US")
//                 .then((value) => teamData.members[index].phoneNumber = value)
//                 .then((value) {
//               setState(() {
//                 isMemberCheckedAvailable = true;
//               });
//             });
//           }
//         });
//       }
//     });
//   }

  // check for valid phone number
  Future<bool> _isValidNumber(String number, String isoCode) async {
    var isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: number, isoCode: isoCode);
    return isValid;
  }

  Future<String> _normalizePhonNumber(String number, String isoCode) async {
    var generatedNumber = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: number, isoCode: isoCode);
    return generatedNumber;
  }