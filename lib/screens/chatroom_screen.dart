import 'package:flutter/material.dart';

class ChatroomScreen extends StatelessWidget {
  final String groupName;

  const ChatroomScreen({Key? key, required this.groupName}) : super(key: key);

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
                    'GroupChat',
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
          
          // Chat Header
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Chartroom',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  groupName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 0),
          
          // Chat Messages
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildMessage('User1', 'Hello everyone!', false),
                SizedBox(height: 8),
                _buildMessage('User2', 'Hi User1! How are you?', false),
                SizedBox(height: 8),
                _buildMessage('User1', 'I\'m good, working on the math problems', false),
                SizedBox(height: 8),
                _buildMessage('User2', 'Same here, question 5 is tricky', false),
                SizedBox(height: 8),
                _buildMessage('User1', 'Let me help you with that', false),
                SizedBox(height: 8),
                _buildMessage('User2', 'Thanks!', false),
              ],
            ),
          ),
          
          // Message Input
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a message...',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blue[800]),
                          onPressed: () {
                            // Send message
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String user, String message, bool isCurrentUser) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 2),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}