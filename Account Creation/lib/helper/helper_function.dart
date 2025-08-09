import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';



gotoPage(Widget page, BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>  page  ,));
}


gotoPageAndRemove(Widget page, BuildContext context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  page  ,));
}


gotoPageAndRemoveAll(Widget page, BuildContext context){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  page  ,),  (route)=>false  );
}





showLoading(BuildContext context){
  showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Processing..."),
              SizedBox(height: 25,),
              CupertinoActivityIndicator()
            ],
          ),
        ),
      );
    },
  );
}



hideLoading(BuildContext context){
  Navigator.pop(context);
}

















showNotification(String title, message, BuildContext context, {bool isError = false}  ){

  toastification.show(
  context: context, // optional if you use ToastificationWrapper
  type:  isError ? ToastificationType.error :    ToastificationType.success,
  style: ToastificationStyle.flatColored,
  autoCloseDuration: const Duration(seconds: 5),
  title: Text(title),
  
  description: RichText(text: TextSpan(text: message)),
  alignment: Alignment.topRight,
  direction: TextDirection.ltr,
  
  icon:    Icon( isError?  Icons.cancel  :  Icons.check),
  showIcon: true, // show or hide the icon
  
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(
      color: Color(0x07000000),
      blurRadius: 16,
      offset: Offset(0, 16),
      spreadRadius: 0,
    )
  ],
  showProgressBar: true,
  closeButton: ToastCloseButton(
    showType: CloseButtonShowType.onHover,
    buttonBuilder: (context, onClose) {
      return OutlinedButton.icon(
        onPressed: onClose,
        icon: const Icon(Icons.close, size: 20),
        label: const Text('Close'),
      );
    },
  ),
  closeOnClick: false,
  pauseOnHover: true,
  dragToClose: true,
  applyBlurEffect: true,
  callbacks: ToastificationCallbacks(
    onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
    onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
    onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
  ),
);

}