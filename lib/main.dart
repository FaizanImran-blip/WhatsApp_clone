import 'package:flutter/material.dart';

void main() {
  runApp(WhatsAppCloneApp());
}

class WhatsAppCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF25D366),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ChatItem> chats = [
    ChatItem(
      name: 'Sara',
      message: 'Hey, how are you?',
      time: '10:15 AM',
      avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Ali',
      message: 'Let\'s meet tomorrow.',
      time: '9:30 AM',
      avatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      unreadCount: 0,
    ),
    ChatItem(
      name: 'Family Group',
      message: 'Mom: Dinner at 8 PM',
      time: 'Yesterday',
      avatarUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/WhatsApp_icon.svg/1024px-WhatsApp_icon.svg.png',
      unreadCount: 5,
    ),
    ChatItem(
      name: 'John',
      message: 'Check out this photo!',
      time: 'Yesterday',
      avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      unreadCount: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  void openChat(ChatItem chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(chat: chat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        backgroundColor: Color(0xFF075E54),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                onTap: () => openChat(chat),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(chat.avatarUrl),
                  radius: 25,
                ),
                title: Text(
                  chat.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chat.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.time,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 5),
                    chat.unreadCount > 0
                        ? Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xFF25D366),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${chat.unreadCount}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
          Center(
            child: Text(
              'Status Updates',
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
          ),
          Center(
            child: Text(
              'Call History',
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF25D366),
        child: Icon(Icons.message, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Start a new chat')),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final ChatItem chat;
  ChatScreen({required this.chat});

  final List<Message> messages = [
    Message(text: 'Hello!', isSentByMe: false),
    Message(text: 'Hi, how are you?', isSentByMe: true),
    Message(text: 'I am good, thanks.', isSentByMe: false),
    Message(text: 'Great to hear!', isSentByMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
        backgroundColor: Color(0xFF075E54),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: msg.isSentByMe ? Color(0xFFDCF8C6) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: msg.isSentByMe ? Radius.circular(12) : Radius.circular(0),
                        bottomRight: msg.isSentByMe ? Radius.circular(0) : Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(msg.text, style: TextStyle(fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.emoji_emotions, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (text) {},
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, color: Color(0xFF075E54)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.unreadCount,
  });
}

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}
