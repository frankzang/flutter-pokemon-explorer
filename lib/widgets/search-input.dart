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
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black45, width: 2.0))),
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
        ));
  }
}
