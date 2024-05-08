import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base/functions.dart';
import '../../model/Report.dart';
import '../../widgets/mybutton.dart';
import '../../widgets/mytext.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {

  List<Report> reports = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: MyTextView(
                      data: 'Reports',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                      maxlines: 1,
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return FutureBuilder<List<Report>>(
                        future: MyFunctions().fetchReports(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No reports found'));
                          } else {
                            reports = snapshot.data!;
                            return ListView(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: reports.length,
                                  itemBuilder: (context, index) {
                                    final report = reports[index];
                                    return Card(
                                      child: Column(
                                        children: [
                                          // Image
                                          Image.network(report.imageUrl),

                                          MyButton(
                                            text: 'Open in Maps',
                                            color: Colors.indigoAccent,
                                            function: () async {
                                              final url = 'https://www.google.com/maps/@${report.latitude},${report.longitude},15z';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                print('Could not launch maps');
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 30),
                              ],
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
