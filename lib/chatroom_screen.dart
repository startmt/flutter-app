import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'component/appbar.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  final DocumentReference session;
  final String name;
  final String uid;
  ChatRoomScreen(
      {Key key,
      @required this.session,
      @required this.name,
      @required this.uid})
      : super(key: key);
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final Firestore firestore = Firestore.instance;
  final df = DateFormat('kk:mm a');
  bool _isComposingMessage = false;

  List<Widget> getReceivedMessageLayout(Map<String, dynamic> data) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data['message'],
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 3.0,bottom: 15),
              child: Text(
                df.format(DateTime.fromMillisecondsSinceEpoch(
                    data['time'].millisecondsSinceEpoch)),
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> getSentMessageLayout(Map<String, dynamic> data) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(data['message'],
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 3.0, bottom: 15),
              child: Text(
                  df.format(DateTime.fromMillisecondsSinceEpoch(
                      data['time'].millisecondsSinceEpoch)),
                  style: Theme.of(context).textTheme.body2),
            ),
          ],
        ),
      )
    ];
  }

  managemessage(DocumentSnapshot data) {
    DocumentReference userRef =
        firestore.collection('user').document(this.widget.uid);
    return userRef == data.data['sender']
        ? getSentMessageLayout(data.data)
        : getReceivedMessageLayout(data.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppbarImplement.getAppBar(this.widget.name, context),
            preferredSize: const Size(50, 45)),
        body: Container(
            child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                stream: this
                    .widget
                    .session
                    .collection('message')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  print(snapshot.hasData);
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return Container(
                            child: Row(
                                children: managemessage(
                                    snapshot.data.documents[index])));
                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextBar()),
          ],
        )));
  }

  Widget _buildTextBar() {
    return IconTheme(
        data: IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();
    setState(() {
      _isComposingMessage = false;
    });
    _sendMessage(text);
  }

  IconButton getDefaultSendButton() {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  void _sendMessage(String text) {
    DocumentReference userRef =
        firestore.collection('user').document(this.widget.uid);
    if (text != '') {
      this
          .widget
          .session
          .collection('message')
          .add(({'message': text, 'sender': userRef, 'time': DateTime.now()}))
          .then((ref) => {
                this.widget.session.setData(({'lastmessage': ref}))
              });
    }
  }
}
