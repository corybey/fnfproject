import 'package:flutter/material.dart';
import 'create_group_screen.dart';
import 'study_room_screen.dart';
import 'signup_login_screen.dart';
import 'profile_screen.dart';
import 'groups_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.blue[800],
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpOnLoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'FOCUSNFLOW',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Create Study Group Button
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateGroupScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Create Study Group',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Sessions In Progress
                  Text(
                    'Sessions In Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Group Cards
                  _buildGroupCard('GroupName', 'subjectTimer:00:00:00'),
                  SizedBox(height: 16),
                  _buildGroupCard('GroupName', 'subjectTimer:00:00:00'),
                  SizedBox(height: 16),
                  _buildGroupCard('GroupName', 'subjectTimer:00:00:00'),
                ],
              ),
            ),
          ),
          
          // Bottom Navigation
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Home', true),
                _buildNavItem(Icons.people, 'Groups', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupsScreen()),
                  );
                }),
                _buildNavItem(Icons.add, 'Create', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateGroupScreen()),
                  );
                }),
                _buildNavItem(Icons.person, 'Profile', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(String groupName, String timer) {
    return GestureDetector(
      onTap: () {
        // Navigate to study room
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              groupName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              timer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.blue[800] : Colors.grey[600],
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.blue[800] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}