import 'package:flutter/material.dart';
import 'package:forecast_app/core/widgets/custom_text.dart';


class MessagesUi{
  snackUi(BuildContext c, String m){
    var s = SnackBar(
      backgroundColor: Colors.grey,
      content: CustomText(text: m, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, height: 0.08,),
    );
    if(c.mounted) ScaffoldMessenger.of(c).showSnackBar(s);
  }
  snackE(BuildContext c, String m){
    var s = SnackBar(
      backgroundColor: Colors.red,
      content: CustomText(text: m, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, height: 0.08,),
    );
    if(c.mounted) ScaffoldMessenger.of(c).showSnackBar(s);
  }
}