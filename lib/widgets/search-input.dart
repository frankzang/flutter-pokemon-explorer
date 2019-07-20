import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchInput extends StatefulWidget {
  final _controller = TextEditingController();
  final _searchInputFocus = FocusNode();
  final Function onFieldSubmitted;

  SearchInput({this.onFieldSubmitted});

  @override
  State<StatefulWidget> createState() {
    return _SearchInputState();
  }
}

class _SearchInputState extends State<SearchInput> {
  @override
  void dispose() {
    widget._controller.dispose();
    widget._searchInputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    spreadRadius: 2,
                    offset: Offset(0, 5))
              ]),
          child: TextFormField(
            autofocus: true,
            onFieldSubmitted: (text) {
              if (text.isNotEmpty) {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                widget?.onFieldSubmitted(text);
              }
            },
            focusNode: widget._searchInputFocus,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Type pokemon name here",
              hintStyle: TextStyle(color: Colors.black38),
              icon: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            controller: widget._controller,
          )),
    );
  }
}
