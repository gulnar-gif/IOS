
import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessApp());
}

class BusinessApp extends StatelessWidget {
  const BusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  bool _isFollowing = false;
  bool _isLiked = false;
  int _followerCount = 375;
  int _likesCount = 307;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text('Instagram Profile'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.pink,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Gulnar Habibullaeva',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '_khabibullaveva',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),

                Text(
                  'Student of Narxoz University',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$_followerCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      Column(
                        children: [
                          Text(
                            '$_likesCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Likes ❤️',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      icon: Icon(
                        _isFollowing
                            ? Icons.check
                            : Icons.person_add,
                      ),
                      label: Text(
                        _isFollowing ? 'Following' : 'Follow',
                      ),
                    ),

                    SizedBox(width: 12),

                    OutlinedButton.icon(
                      onPressed: _toggleLike,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.pink,
                      ),
                      icon: Icon(
                        _isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text('Like'),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                OutlinedButton(
                  onPressed: _reset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.purple,
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;

      if (_isFollowing) {
        _followerCount++;
      } else {
        _followerCount--;
      }
    });
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likesCount--;
        _isLiked = false;
      } else {
        _likesCount++;
        _isLiked = true;
      }
    });
  }

  void _reset() {
    setState(() {
      _isFollowing = false;
      _isLiked = false;
      _followerCount = 375;
      _likesCount = 307;
    });
  }
}