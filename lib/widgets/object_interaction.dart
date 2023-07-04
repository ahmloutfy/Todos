import 'package:flutter/material.dart';

class CardItem {
  String? title;
  String? description;

  CardItem({this.title, this.description});
}

class ObjectInteraction extends StatefulWidget {
  const ObjectInteraction({super.key});

  @override
  ObjectInteractionState createState() => ObjectInteractionState();
}

class ObjectInteractionState extends State<ObjectInteraction> {

  final FocusNode _titleFocusNode = FocusNode();

  void openKeyboard () {
    FocusScope.of(context).requestFocus(_titleFocusNode);

  }

  List<CardItem> cardList = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? selectedItemIndex;

  void addCard(CardItem card) {
    setState(() {
      cardList.add(card);
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  void editCard(CardItem newCard) {
    setState(() {
      cardList[selectedItemIndex!] = newCard;
      selectedItemIndex = null;
    });
    _titleController.clear();
    _descriptionController.clear();
  }

  void deleteCard(int index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  void _showDialog({CardItem? card}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(card != null ? 'Edit Card' : 'Add Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                focusNode: _titleFocusNode,
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Enter title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration:
                const InputDecoration(hintText: 'Enter description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                selectedItemIndex = null;
                _titleController.clear();
                _descriptionController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(card != null ? 'Update' : 'Add'),
              onPressed: () {
                if (card != null) {

                  editCard(

                    CardItem(

                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                  );
                } else {

                  addCard(
                    CardItem(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                  );
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card List'),
      ),
      body: ListView.builder(
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          final card = cardList[index];
          return ListTile(
            title: Text(card.title!),
            subtitle: Text(card.description!),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteCard(index);
              },
            ),
            onTap: () {
              selectedItemIndex = index;
              _titleController.text = card.title!;
              _descriptionController.text = card.description!;
              _showDialog(card: card);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialog();
        },
      ),
    );
  }
}