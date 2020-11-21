import 'package:firebase_database/firebase_database.dart';

class FirebaseMethod {
  // DataReference
  DatabaseReference teamReference = FirebaseDatabase.instance.reference().child('Teams');

  // Team Member
  getTeamMember() async {
    var fetchedData;
    await teamReference.once().then((DataSnapshot snapshot) {
      fetchedData = new Map<String, dynamic>.from(snapshot.value);
      print(fetchedData);
    });
    return fetchedData;
  }
}