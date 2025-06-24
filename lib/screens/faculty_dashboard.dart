import 'package:flutter/material.dart';

class FacultyDashboardScreen extends StatefulWidget {
  const FacultyDashboardScreen({super.key});

  @override
  State<FacultyDashboardScreen> createState() => _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState extends State<FacultyDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Dashboard'),
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To Check',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF50),
              ),
            ),
            SizedBox(height: 16),
            _buildSubmissionCard(
              'Crowd Monitoring...',
              'Submitted last week',
              () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            SizedBox(height: 12),
            _buildSubmissionCard(
              'Thesis Management...',
              'Submitted last month',
              () {},
            ),
            SizedBox(height: 32),
            Text(
              'New Arrived Paper',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF50),
              ),
            ),
            SizedBox(height: 16),
            _buildNotificationCard('Crowd Monitoring...', 'Submitted this day'),
            SizedBox(height: 12),
            _buildNotificationCard(
              'Thesis Management...',
              'Submitted this day',
            ),
            SizedBox(height: 12),
            _buildNotificationCard(
              'Financial Management...',
              'Submitted this day',
            ),
            SizedBox(height: 12),
            _buildNotificationCard(
              'Feed Formulation System',
              'Submitted this day',
            ),
            SizedBox(height: 12),
            _buildNotificationCard(
              'Library Management System',
              'Submitted this week',
            ),
            SizedBox(height: 12),
            _buildNotificationCard(
              'Equipment Management...',
              'Submitted this week',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Thesis',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSubmissionCard(
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.description, color: Colors.grey[600]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Color(0xFF4CAF50), fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.grey[600]),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.notifications, color: Colors.grey[600], size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Color(0xFF4CAF50), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
