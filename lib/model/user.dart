import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  // profilephoto;
  String email;
  String uid;

  myUser({
    required this.name,
    //required this.profilephoto,
    required this.email,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {"name": name, "email": email, "uid": uid};
  // {"name": name, "profilephoto": profilephoto, "email": email, "uid": uid};

  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUser(
      email: snapshot['email'],
      name: snapshot['name'],
      //profilephoto: snapshot['profilephoto'],
      uid: snapshot['uid'],
    );
  }
}
