//import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/adaptive_flat_button.dart';
//import 'package:flutter/scheduler.dart';
class NewTransaction extends StatefulWidget {
  NewTransaction(this.txAddTransaction);

  final Function txAddTransaction;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControllor = TextEditingController();

  final _amountControllor = TextEditingController();
  DateTime _pickedDate;

  void _sumbmittedData() {
    final enteredTitle = _titleControllor.text;
    final enteredAmount = double.parse(_amountControllor.text);
    //final enteredDate=DateFormat.yMMMMEEEEd().format(_pickedDate);
    // Function enteredDate=Function.apply( _pickedDate)
    if(_amountControllor.text.isEmpty){
      return;
    }    
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
      return;
    }
    widget.txAddTransaction(
      enteredTitle,
      enteredAmount,
      _pickedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else
        setState(() {
          _pickedDate = pickedDate;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
       //child: Container(
            // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +10,
          ),
           child: Column(
              mainAxisSize: MainAxisSize.min,
            //  crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(                  
                
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleControllor,
                  onSubmitted: (_) => _sumbmittedData(),
                  // onChanged: (val) {
                  //   titleInput = val;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountControllor,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _sumbmittedData(),
                  // onChanged: (val) => amountInput = val,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _pickedDate == null
                              ? 'No date chosen !'
                              : 'Picked date:  ${DateFormat.yMd().format(_pickedDate)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                   AdaptiveFlatButton('Choose Date:', _presentDatePicker),
                     
                    ],
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  // textColor: Colors.blue,
                  onPressed: _sumbmittedData,
                ),
              ],
            ),
           
    //      showModalBottomSheet(
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    // backgroundColor: Colors.black,
    // context: context,
    // isScrollControlled: true,
    // builder: (context) => Padding(
    //   padding: const EdgeInsets.symmetric(horizontal:18 ),
     
    
             
    ),
          
        
      ),
    );
    
  }
}
