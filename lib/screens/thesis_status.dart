import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/dashboard.dart';

class ThesisStatusScreen extends StatelessWidget {
  const ThesisStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'Thesis Status',
          showActions: false,
          withLeading: true,
          locationScreen:
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Timeline',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  buildTimelineItem(
                    title: 'Elizabeth R. Genotiva',
                    timeAgo: '1 week ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Nor-aine Corpuz',
                    timeAgo: '1 day ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Ryan Gonzaga',
                    timeAgo: '3 days ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Ralph Butch Garidan',
                    timeAgo: '4 days ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Catherine Daffon',
                    timeAgo: '5 days ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Arjay Agbunag',
                    timeAgo: '6 days ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Sherly Ortiza',
                    timeAgo: '1 week ago',
                    subtitle:
                        'Please check the spacing and margins of the manuscript. '
                        'It is not following the required format.',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                  buildTimelineItem(
                    title: 'Ready for RDO',
                    subtitle:
                        'Congratulations! Please ready your document for RDO.',
                    timeAgo: '2 days ago',
                    isLast: true,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildGreenButton(
              'Back',
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
