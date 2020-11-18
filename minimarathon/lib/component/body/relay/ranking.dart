import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import '../../../util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();


class Ranking extends StatefulWidget {
  @override
  RankingState createState() => RankingState();
}
List<_Row> _rows= new List<_Row>();
//List<_Row> _rows= new List<_Row>(10);
class RankingState extends State<Ranking> {
  final String username = 'Jong Ha Park';

  // RankingState(){
  //   _rows.add(new _Row("dfa","dfad"));
  //   _rows.clear();
  //   var query = referenceDatabase.orderByChild('Timer');
  //   String name;
  //   int timer;
  //   query.onChildAdded.forEach((event) {
  //     name = event.snapshot.value['Name'];
  //     timer = event.snapshot.value['Timer'];
  //
  //     int ihour = timer~/3600;
  //     int imin = (timer - (ihour*3600))~/60;
  //     int isec = timer - (ihour*3600) - (imin*60);
  //     String hour = (ihour<10? "0":"") + ihour.toString();
  //     String min = (imin<10? "0":"") + imin.toString();
  //     String sec = (isec<10? "0":"") + isec.toString();
  //     String time = hour+":"+min+":"+sec;
  //     // _Row row = new _Row(1,name, time);
  //     _rows.add(new _Row(name, time));
  //   });
  //
  // }

  @override
  void initState() {
    super.initState();{ _rows.clear();  print(_rows.length);}
  }

  @override
  Widget build(BuildContext context) {

    return CustomHeader(
      title: Text("Ranking"),
      body: ListView(
        padding: const EdgeInsets.all(2),
        children: [
          PaginatedDataTable(
            header: makeText('Who walked fast?', Colors.black87, 20),
            rowsPerPage: 10,
            columns: [
              DataColumn(label: Text('Rank')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Time')),
            ],
            source: _DataSource(context),
          ),
        ],
      ),
    );
  }
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


  _DataSource(this.context) {

    var query = referenceDatabase.orderByChild('Timer');
    String name;
    int timer;
    query.onChildAdded.forEach((event) {
      name = event.snapshot.value['Name'];
      timer = event.snapshot.value['Timer'];

      int ihour = timer~/3600;
      int imin = (timer - (ihour*3600))~/60;
      int isec = timer - (ihour*3600) - (imin*60);
      String hour = (ihour<10? "0":"") + ihour.toString();
      String min = (imin<10? "0":"") + imin.toString();
      String sec = (isec<10? "0":"") + isec.toString();
      String time = hour+":"+min+":"+sec;
      _rows.add(new _Row(name, time));
    });

    _rows.add(new _Row("fd", "fdfdfdf"));
    //_rows.add(new _Row(1,, "fd"));
    // _rows = <_Row>[
    //   // _Row(1, 'Mados', '00:52:33'),
    //   // _Row(2, 'kook', '00:53:53'),
    //   // _Row(3, 'tata', '00:56:43'),
    //   // _Row(4, 'puni', '00:58:17'),
    //   // _Row(1, 'Mados', '00:52:33'),
    //   // _Row(2, 'kook', '00:53:53'),
    //   // _Row(3, 'tata', '00:56:43'),
    //   // _Row(4, 'puni', '00:58:17'),
    //   // _Row(1, 'Mados', '00:52:33'),
    //   // _Row(2, 'kook', '00:53:53'),
    //   // _Row(3, 'tata', '00:56:43'),
    //   // _Row(4, 'puni', '00:58:17'),
    //   // _Row(1, 'Mados', '00:52:33'),
    //   // _Row(2, 'kook', '00:53:53'),
    //   // _Row(3, 'tata', '00:56:43'),
    //   // _Row(4, 'puni', '00:58:17'),
    // ];


  }

  final BuildContext context;



  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow(

      cells: [
        DataCell(Text(index.toString())),
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