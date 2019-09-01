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
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black54,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  onFieldSubmitted: (text) {
                    onSubmit();
                  },
                  focusNode: widget._searchInputFocus,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ex. Lapras or 131",
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                  controller: widget._controller,
                ),
              ),
              IconButton(
                onPressed: onSubmit,
                icon: Icon(Icons.search),
                color: Colors.black54,
              ),
            ],
          )),
    );
  }

  void onSubmit() {
    final text = widget._controller.text;
    if (text.isNotEmpty) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      widget?.onFieldSubmitted(text);
      widget._controller.clear();
    }
  }
}
