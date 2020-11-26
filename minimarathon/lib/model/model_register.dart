// model
class Single {
  String name = "  Please type your name . . .";
  String phoneNumber;
  int donationFee = 10;
  bool moreVolunteer = false;
  Relay relay = new Relay();

  Map toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'donationFee': donationFee,
        'moreVolunteer': moreVolunteer,
        'relay': relay.toJson()
      };
}

class Relay {
  double runningDistance = 0.0;
  int timer = 0;

  Relay({this.runningDistance, this.timer});

  factory Relay.fromJson(Map<String, dynamic> parsedJson) {
    return Relay(
        runningDistance: parsedJson['runningDistance'] as double,
        timer: parsedJson['timer'] as int);
  }

  Map toJson() => {'runningDistance': runningDistance, 'timer': timer};
}

class Member {
  String name;
  String phoneNumber;
  bool moreVolunteer;
  Relay relay = new Relay();

  Member({this.name, this.phoneNumber, this.moreVolunteer, this.relay});

  factory Member.fromJson(Map<String, dynamic> parsedJson) {
    return Member(
        name: parsedJson['name'],
        phoneNumber: parsedJson['phoneNumber'],
        moreVolunteer: parsedJson['moreVolunteer'],
        relay: Relay.fromJson(parsedJson['relay']));
  }
  Map toJson() {
    Map newRelay = this.relay != null ? this.relay.toJson() : null;
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'moreVolunteer': moreVolunteer,
      'relay': newRelay
    };
  }
}

class Team {
  String teamName;
  Member leader;
  List<Member> members;
  int donationFee;
  bool isPaid;

  Team(
      {this.teamName,
      this.leader,
      this.members,
      this.donationFee,
      this.isPaid});

  // read
  factory Team.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Team Member'] as List;
    List<Member> memberList =
        list.map((index) => Member.fromJson(index)).toList();

    return Team(
        teamName: parsedJson['teamName'],
        leader: Member.fromJson(parsedJson['Team Leader']),
        members: memberList,
        donationFee: parsedJson['donationFee'],
        isPaid: parsedJson['isPaid']);
  }
  // write
  Map toJson() {
    List<Map> members = this.members != null
        ? this.members.map((i) => i.toJson()).toList()
        : null;

    return {
      'teamName': teamName,
      'leader': leader.toJson(),
      'members': members,
      'donationFee': donationFee,
      'isPaid': isPaid
    };
  }
}
