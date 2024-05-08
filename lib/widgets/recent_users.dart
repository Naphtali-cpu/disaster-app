import 'package:disastermanagement/model/UsersModel.dart';
import 'package:disastermanagement/widgets/mytext.dart';
import 'package:flutter/material.dart';

import '../base/formatter.dart';

class RecentUsers extends StatelessWidget {
  const RecentUsers({
    Key? key,
    required this.userslist,
  }) : super(key: key);

  final List<UserModel> userslist;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 30, 400, 0),
      width: 1800,
      padding: EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFBEDAFF),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.black),
              child: DataTable(
                  columnSpacing: 20.0,
                  columns: const [
                    DataColumn(
                      label: MyTextView(
                        data: 'Names',
                        fontsize: 18,
                        colors: Color(0xFF0B61BE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    DataColumn(
                      label: MyTextView(
                        data: 'Email',
                        fontsize: 18,
                        colors: Color(0xFF0B61BE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    DataColumn(
                      label: MyTextView(
                        data: 'Type',
                        fontsize: 18,
                        colors: Color(0xFF0B61BE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    DataColumn(
                      label: MyTextView(
                        data: 'Created At',
                        fontsize: 18,
                        colors: Color(0xFF0B61BE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  rows: userslist
                      .map((data) => DataRow(cells: [
                            DataCell(MyTextView(
                                data: data.name,
                                fontsize: 18,
                                fontWeight: FontWeight.w700)),
                            DataCell(MyTextView(
                                data: data.email,
                                fontsize: 18,
                                fontWeight: FontWeight.w700)),
                            DataCell(MyTextView(
                                data: data.role,
                                fontsize: 18,
                                fontWeight: FontWeight.w700)),
                            DataCell(MyTextView(
                                data: MyFormatter.dateformater(DateTime.parse(data.created_at)),
                                fontsize: 18,
                                fontWeight: FontWeight.w700)),
                          ]))
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }
}
