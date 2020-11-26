import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/palette.dart';
import '../../../util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// model
import '../../../model/model_register.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();

class Ranking extends StatefulWidget {
  @override
  RankingState createState() => RankingState();
}

List<Member> memberList = new List<Member>();

//List<_Row> _rows= new List<_Row>(10);
class RankingState extends State<Ranking> {
  final String username = 'Jong Ha Park';
  // List<_Row> _rows = new List<_Row>();
  var currentRowList = List<_Row>();
  final datasource = new _DataSource();

  @override
  void initState() {
    super.initState();
    readList();
  }

  void setData() {
    setState(() {
      datasource._rows = currentRowList;
    });
  }

  String makeTimeString(int timer) {
    int ihour = timer ~/ 3600;
    int imin = (timer - (ihour * 3600)) ~/ 60;
    int isec = timer - (ihour * 3600) - (imin * 60);
    String hour = (ihour < 10 ? "0" : "") + ihour.toString();
    String min = (imin < 10 ? "0" : "") + imin.toString();
    String sec = (isec < 10 ? "0" : "") + isec.toString();
    String time = hour + ":" + min + ":" + sec;
    return time;
  }

  void readList() async {
    String name;
    int timer;
    List<_Mem> tmpList = new List<_Mem>();

    // Single
    var squery = referenceDatabase.child('Single');
    await squery.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        dynamic values = dataSnapshot.value;
        values.forEach((key, value) {
          name = value['name'];
          dynamic relay = value['relay'];
          timer = relay['timer'];
          tmpList.add(new _Mem(name, timer));
        });
      }
    });

    // Team
    var tquery = referenceDatabase.child('Teams');
    await tquery.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        dynamic values = dataSnapshot.value;
        values.forEach((key, value) {
          // get leaders information
          dynamic leader = value['leader'];
          name = leader['name'];
          dynamic relay = leader['relay'];
          timer = relay['timer'];
          tmpList.add(new _Mem(name, timer));

          // get members information
          List<dynamic> members = value['members'];
          members.forEach((i) {
            name = i['name'];
            dynamic relay = i['relay'];
            timer = relay['timer'];
            tmpList.add(new _Mem(name, timer));
          });
        });
      }
    });

    bool isSort = false;
    List<_Row> sortedList = new List<_Row>();

    setState(() {
      tmpList.sort((a, b) =>
          isSort ? (a.time).compareTo(b.time) : (b.time).compareTo(a.time));
      isSort = !isSort;
      tmpList.forEach((i) {
        String name = i.name;
        String time = makeTimeString(i.time);
        _Row r = new _Row(name, time);
        sortedList.add(r);
      });
      currentRowList = sortedList;
    });

    setData();
  }

  haha() {
    return this.datasource;
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Ranking",
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          Container(
            decoration: BoxDecoration(
                // color: lightwhite,
                // border: Border.all(color: lightwhite, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: PaginatedDataTable(
              header: makeText('Who walked fast?', Colors.black87, 20),
              rowsPerPage: 10,
              horizontalMargin: 30,
              columns: [
                DataColumn(label: Text('Rank')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Time')),
              ],
              source: _DataSource.withrows(currentRowList),
            ),
          )
        ],
      ),
    );
  }
}

class _Mem {
  _Mem(this.name, this.time);
  final String name;
  final int time;
}

class _Row {
  _Row(
    this.name,
    this.time,
  );

  final String name;
  final String time;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  var _rows = new List<_Row>();
  int _selectedCount = 0;
  _DataSource() {
    _rows = new List<_Row>();
  }
  _DataSource.withrows(var _rows) {
    this._rows = _rows;
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(row.name)),
        DataCell(Text(row.time.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
