import 'package:flutter/material.dart';
import 'package:local_storage/src/data/shared_prefs.dart';
import 'package:local_storage/src/screens/drawer.dart';

Future<bool> Function() getMasterFun = () async {
  SPSettings sp = SPSettings();
  await sp.init();
  return sp.getMaster();
};

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  SPSettings sp = SPSettings();
  Future<bool> getMaster = getMasterFun();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController password1Text = TextEditingController();
    TextEditingController password2Text = TextEditingController();

    Widget image = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1965&q=80'))
      ),
    );

    Widget formEnterMaster = Form(
        key: _formKey,
        child: Column(
      children: [
        TextFormField(
        controller: password1Text,
        obscureText: true ,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please enter master password';
          }
          return null;
        },),
        ElevatedButton(onPressed: (){
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        }, child: Text('Login'))
      ],
    ));

    Widget formCreateMaster = Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Please set master password to continue'),
            TextFormField(
              controller: password1Text,
              obscureText: true ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter master password';
                }
                return null;
              },),
            TextFormField(
              controller: password2Text,
              obscureText: true ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter master password';
                }
                if (value != password1Text.text) {
                  return 'enter same password as above';
                }
                return null;
              },),
            ElevatedButton(onPressed: (){
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            }, child: Text('Login'))
          ],
        ));


    return Scaffold(
      appBar: AppBar(title: Text("home"),),
      drawer: APPDrawer(),
      body: FutureBuilder(
        future: getMaster ,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          List<Widget> form = [image];
          if (snapshot.hasData) {
            bool isMasterSet = snapshot.data!;
            // no shared preference data, meaning new user
            if (isMasterSet) {
              form.add(formEnterMaster);
            }
            else {
              form.add(formCreateMaster);
            }
          }
          return Stack(
            children: form
          );
        },
        ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text("home"),),
    //   drawer: APPDrawer(),
    //   body: Stack(
    //     children: [
    //       image,
    //
    //     ],
    //   ),
    //
    // );

  }
}
