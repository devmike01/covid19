
import 'package:covid19/utils/apppreference.dart';
import 'package:covid19/utils/menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainSettingsPage extends StatefulWidget {
  final AppPreference appPreference;

  MainSettingsPage(this.appPreference);

  static void start(BuildContext context, AppPreference appPreference) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MainSettingsPage(appPreference)),
    );
    //Navigator.push(context,
    // MaterialPageRoute(builder: (context) => DashboardPage
    // (appPreference)));
  }

  @override
  MainSettingsPageState createState() => MainSettingsPageState(appPreference);
}

class MainSettingsPageState extends State<MainSettingsPage>{

  final AppPreference appPreference;

  MainSettingsPageState(this.appPreference);

  List<Widget> settingItems;


  @override
  void initState(){
    super.initState();
    settingItems = List();
    settingItems.add(new InkWell(
        child: new InkWell(
          onTap: (){
            Utils.showAlert(context, 'Phone: +2348141570419\nEmail: dev'
                '.gbenga@gmail.com\nTwitter: twitter.com\\iam_devmike01', 'Co'
                'ntact Me');
          },
          child: ListTile(
            leading:  Icon(Icons.contacts, color: Colors.blueGrey),
            subtitle: Text('Contact the developer'),
            title: Text('Contacts'),
          ),
        )
    ));
    settingItems.add(new InkWell(
      child: ListTile(
        leading: Icon(Icons.description, color: Colors.blueGrey),
        title: Text('About App'),
        subtitle: Text('Learn more about COVID-19 app'),
      ),
      onTap: (){
        Utils.showAlert(context, "All the COVID-19 diagnostic questions are based strictly"
            " on WHO guidelines\nCredit: http://infermedica.com}", "Notice");
      },
    ));

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text('Settings', style: TextStyle(fontSize: 15),),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(getListView().length, (i) => settingItems[i]),
      ),
    );
  }
  
  List<Widget> getListView(){

    return settingItems;
  }

}