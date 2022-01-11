import 'package:flutter/material.dart';
import 'package:local_storage/src/data/sembast_db.dart';
import 'package:local_storage/src/models/password_model.dart';


class PasswordDetail extends StatefulWidget {
  final Password password;
  final bool isNew ;
   bool isEdit;
  PasswordDetail(this.password, this.isNew,  {this.isEdit=false,Key? key}) : super(key: key);

  @override
  State<PasswordDetail> createState() => _PasswordDetailState();
}

class _PasswordDetailState extends State<PasswordDetail> {
  final TextEditingController nameTxtController = TextEditingController();
  final TextEditingController passwordTxtController = TextEditingController();
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    nameTxtController.text = widget.password.name;
    passwordTxtController.text = widget.password.password;
    return AlertDialog(
      title: widget.isNew ? Text("Enter new Password") : Text("Update Password"),
      content: Column(
        children: [
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: nameTxtController,
              decoration: InputDecoration(
                hintText: "Description"
              ),
            ),
          TextField(
            style: Theme.of(context).textTheme.bodyText2,
            controller: passwordTxtController,
            obscureText: obscureText,
            decoration: InputDecoration(
                hintText: "Password",
               suffixIcon: IconButton(
                 onPressed: () {
                   setState(() {
                     obscureText = !obscureText;
                   });
                 },
                 icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
               ),
            ),
          )
        ],
      ),
      actions: [
        widget.isEdit ? TextButton(onPressed: (){
          widget.password.name = nameTxtController.text;
          widget.password.password = passwordTxtController.text;
          var db = SembastDb();
          if (widget.isNew) {
            db.addPassword(widget.password);
          }
          else {
            db.updatePassword(widget.password);
          }
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushNamed(context, "/passwords");

        },
            child: Text("Save")
        ) :  SizedBox.shrink(),
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );
  }
}
