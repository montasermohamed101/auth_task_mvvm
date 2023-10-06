import 'package:flutter/material.dart';

showLoading(BuildContext context){
  showDialog(
      context: context,
      builder: (_)=> const AlertDialog(
        content: Row(
          children: [
            Text('Loading...',style: TextStyle(
                color: Colors.black
            )),
            Spacer(),
            CircularProgressIndicator(),
          ],
        ),
      )
  );
}

hideLoading(BuildContext context){
  Navigator.pop(context);
}

showErrorDialog(BuildContext context,String message){
  showDialog(context: context, builder: (_) =>AlertDialog(
    title: Text("Error!",style: TextStyle(
        color: Colors.black
    )),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message,style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        )),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Ok")),
      ],
    ),
  ));
}