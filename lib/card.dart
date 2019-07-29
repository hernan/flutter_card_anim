import 'package:flutter/material.dart';
import 'package:anim/card_transition.dart';

class Acard extends StatefulWidget {
  @override
  _AcardState createState() => _AcardState();
}

class _AcardState extends State<Acard> {
  Widget _switcherCard;
  String title = 'El Título';
  String subTitle = 'The sub mini title for the card';

  void _editCard() {
    setState(() {
      _switcherCard = TheCardForm(onSave: _updateCard, onCancel: _cancelEdit,);
    });
  }

  void _cancelEdit() {
    setState(() {
      _switcherCard = TheCard(
        onEdit: _editCard,
        cardTitle: title,
        cardSubtitle: subTitle);
    });
  }

  void _updateCard({String title, String subTitle}) {
    setState(() {
      this.title = title;
      this.subTitle = subTitle;
      _switcherCard = TheCard(
        onEdit: _editCard,
        cardTitle: title,
        cardSubtitle: subTitle);
    });
  }

  @override
  void initState() {
    _switcherCard = TheCard(
        onEdit: _editCard,
        cardTitle: title,
        cardSubtitle: subTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardSwitcher'),
      ),
      body: Container(
        color: Colors.amber,
//        width: 300,
        height: 250,
        child: AnimatedSwitcher(
//          reverseDuration: Duration(milliseconds: 3200),
//          switchInCurve: Curves.bounceIn,
//          switchOutCurve: Curves.bounceOut,
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation animation){
            return CardTransition(child: child, turns: animation);
          },
          child: _switcherCard
          ),
      ),
    );
  }
}

class TheCard extends StatelessWidget {
  final Function onEdit;
  final String cardTitle;
  final String cardSubtitle;
  TheCard({ @required this.onEdit, this.cardTitle, this.cardSubtitle });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(cardTitle),
              subtitle: Text(cardSubtitle),
            ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: [
                    FlatButton(
                      child: Text('Edit'),
                      onPressed: onEdit,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class TheCardForm extends StatefulWidget {
  final Function onSave;
  final Function onCancel;

  TheCardForm({ @required this.onSave, @required this.onCancel });

  @override
  _TheCardFormState createState() => _TheCardFormState();
}

class _TheCardFormState extends State<TheCardForm> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _subTitle;

  void _handleSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSave(title: _title, subTitle: _subTitle);
    }
    print('> ..saving $_title, $_subTitle');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: (String value) => _title = value,
                validator: (value) {
                  return value.isEmpty ? 'Can not be empty' : null;
                },
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 12),
                  
                  isDense: true
                ),
              ),
              TextFormField(
                onSaved: (String value) => _subTitle = value,
                validator: (String value) {
                  return value.isEmpty ? 'Can not be empty' : null;
                },
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: TextStyle(fontSize: 12),
                  isDense: true
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: [
                    FlatButton(
                      child: Text('Save'),
                      onPressed: _handleSave,
                    ),
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: widget.onCancel,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}