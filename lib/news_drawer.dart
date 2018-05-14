import 'package:flutter/material.dart';

const String _NamaAkun = 'Randy Arba';
const String _AlamatEmail = 'randy.arba@gmail.com';
const String _NamaSingkat = 'RA';

class NewsDrawer extends StatelessWidget {
  final List<String> labels;
  NewsDrawer({this.labels});

  @override
  Widget build(BuildContext context){
    return new Drawer(
      child: new ListView(
        padding: const EdgeInsets.only(top : 0.0),
        children: _buildDrawer(context),
      ),
    );
  }

  List<Widget> _buildDrawer(BuildContext context){
    List<Widget> childern = [];
    childern..addAll(_buildUserAkun(context))
    ..addAll(_defaultLabels(context))
    ..addAll([new Divider()])
    ..addAll(_buildListLabel(context))
    ..addAll([new Divider()])
    ..addAll(_buildActions(context))
    ..addAll([new Divider()])
    ..addAll(_buildSetting(context));
    return childern;
  }

  List<Widget> _buildUserAkun(BuildContext context){
    return [
      new UserAccountsDrawerHeader(      
        accountName: const Text(_NamaAkun),
        accountEmail: const Text(_AlamatEmail),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: new AssetImage('lib/pic.jpg'),          
        ),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('lib/city.jpg'),
            fit: BoxFit.cover,            
          )
        ),
        otherAccountsPictures: <Widget>[
          new GestureDetector(
            // onTap: () => _onTapOtherAkun(context),
            child: new Semantics(
              label: 'Switch Account',
              child: new CircleAvatar(
                backgroundColor: Colors.blue,
                child: new Text(_NamaSingkat),
              ),
            ),
          )
        ],
      )
    ];
  }

  List<Widget> _defaultLabels(BuildContext context){
    String beranda = 'Beranda';
    return [
      new Container(
        decoration: new BoxDecoration(
          color: Colors.black.withAlpha(95)
        ),      
        child: new ListTile(        
        leading: new Icon(Icons.home, color: Colors.deepPurple, size: 35.0,), selected: true, 
        title: new Text(beranda, style: new TextStyle(color: Colors.black),),
        // onTap: () => _onListTab(context, beranda),
      ),
      )
    ];
  }

  void _onListTab(BuildContext context, String label){

    String stringLabel = label != null ? label : 'Ini Label';    
    showDialog<Null>(
      context: context,
      child: new AlertDialog(
        title: new Text(stringLabel),
        actions: <Widget>[
          new FlatButton(
            child: const Text('Ok'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],

      )
    );
  }

  List<Widget> _buildListLabel(BuildContext context){
    List<Widget> labelList = [];
    labelList.add(
      new ListTile(
        leading: new Text('Startup'),         
        onTap: () => _onListTab(context, 'startup'),
      )
    );

    // labels.forEach((labelName){
    //   labelList.add(
    //     new ListTile(
    //       leading: new Icon(Icons.label),
    //       title: new Text(labelName),
    //       onTap: _onListTab(context, labelName),
    //     )
    //   );
    // });

    labelList.add(
      new ListTile(
        leading: new Icon(Icons.add),
        title: new Text('Buat label baru'),
        onTap: () => _onListTab(context, 'labelbaru'),
      )
    );

    return labelList;
  }

  List<Widget> _buildActions(BuildContext context){
    String simpan = "Penyimpanan";
    String sampah = "Sampah";

    return [
      new ListTile(
        leading: new Icon(Icons.archive),
        title: new Text(simpan),
        onTap: () => _onListTab(context, simpan),      
      ),
      new ListTile(
        leading: new Icon(Icons.delete),
        title: new Text(sampah),
        onTap: () => _onListTab(context, sampah),
      )
    ];
  }

  List<Widget> _buildSetting(BuildContext context){
    String pengaturan = 'Pengaturan';
    String umpanbalik = 'Help and feedback';

    return [
      new ListTile(
        leading: new Icon(Icons.settings),
        title: new Text(pengaturan),
        onTap:  () => _onListTab(context, pengaturan),      
      ),
      new ListTile(
        leading: new Icon(Icons.help),
        title: new Text(umpanbalik),
        onTap: () => _onListTab(context, umpanbalik),
      )
    ];
  }




}