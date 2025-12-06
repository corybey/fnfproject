import 'package:flutter/material.dart';
import 'chatroom_screen.dart';
import 'start_room_screen.dart';

class GroupsScreen extends StatelessWidget {
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
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    '# Groups',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // Group 1
                _buildGroupItem(
                  context,
                  'Mathematics Study',
                  'Mathematics',
                  'Science Building',
                  'Room 301',
                  '2 chatroom',
                ),
                SizedBox(height: 16),
                
                // Group 2
                _buildGroupItem(
                  context,
                  'Physics Lab Group',
                  'Physics',
                  'Engineering Building',
                  'Room 205',
                  '2 chatroom',
                ),
                SizedBox(height: 16),
                
                // Group 3
                _buildGroupItem(
                  context,
                  'Chemistry Study',
                  'Chemistry',
                  'Science Building',
                  'Lab 101',
                  '2 chatroom',
                ),
                SizedBox(height: 16),
                
                // Group 4
                _buildGroupItem(
                  context,
                  'Computer Science',
                  'CS',
                  'Tech Building',
                  'Room 401',
                  '3 chatroom',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, String name, String major, String building, String room, String members) {
    return Container(
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
          // Group Name - Clickable for StartRoom
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartRoomScreen(
                    groupName: name,
                    major: major,
                    building: building,
                    room: room,
                  ),
                ),
              );
            },
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          SizedBox(height: 8),
          
          // Major
          Text(
            major,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          
          // Building
          Text(
            building,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          
          // Room (indented)
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              room,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          
          // Divider
          if (members.isNotEmpty) SizedBox(height: 8),
          if (members.isNotEmpty) Divider(),
          
          // Join Members and Buttons - CLEANED UP
          if (members.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Join Members: $members',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    // Start Room Button - Icon only
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartRoomScreen(
                              groupName: name,
                              major: major,
                              building: building,
                              room: room,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.play_circle_outline, size: 28),
                      color: Colors.green,
                      tooltip: 'Start Room',
                    ),
                    SizedBox(width: 8),
                    
                    // Chatroom Button - Icon only
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatroomScreen(groupName: name),
                          ),
                        );
                      },
                      icon: Icon(Icons.chat_bubble_outline, size: 28),
                      color: Colors.blue[800],
                      tooltip: 'Chatroom',
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}