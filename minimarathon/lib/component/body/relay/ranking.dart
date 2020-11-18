import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/palette.dart';
import '../../../util/text_style.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  @override
  RankingState createState() => RankingState();
}

class RankingState extends State<Ranking> {
  final String username = 'Jong Ha Park';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: Text("Ranking"),
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
              source: _DataSource(context),
            ),
          )
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.rank,
    this.name,
    this.time,
  );

  final int rank;
  final String name;
  final String time;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row(1, 'Mados', '00:52:33'),
      _Row(2, 'kook', '00:53:53'),
      _Row(3, 'tata', '00:56:43'),
      _Row(4, 'puni', '00:58:17'),
      _Row(1, 'Mados', '00:52:33'),
      _Row(2, 'kook', '00:53:53'),
      _Row(3, 'tata', '00:56:43'),
      _Row(4, 'puni', '00:58:17'),
      _Row(1, 'Mados', '00:52:33'),
      _Row(2, 'kook', '00:53:53'),
      _Row(3, 'tata', '00:56:43'),
      _Row(4, 'puni', '00:58:17'),
      _Row(1, 'Mados', '00:52:33'),
      _Row(2, 'kook', '00:53:53'),
      _Row(3, 'tata', '00:56:43'),
      _Row(4, 'puni', '00:58:17'),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

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
