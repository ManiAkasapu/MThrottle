import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:toast/toast.dart';
import '../themes/customcolors.dart';
import '../themes/themeprovider.dart';

class DccServer extends StatefulWidget {

  DccServer({Key key, this.setOdServerDetails, this.disconnectServer, this.togglePower, this.setLoco}) : super(key: key);

  final odServerCallback setOdServerDetails;
  final disconnectCallback disconnectServer;
  final setPowerCallback togglePower;
  final setCVCallback setLoco;

  @override
  _DccServerState createState() => _DccServerState();

}

class _DccServerState extends State<DccServer> {

  final serverTextController = TextEditingController();
  final portTextController = TextEditingController();

  String _serverIp;
  int _port;

  final _serverFormKey = GlobalKey<FormState>();
  final _cvFormKey = GlobalKey<FormState>();
  final locoCvController = TextEditingController();

  String connectText = "Connect";
  String acquireText = "Acquire";

  int _locoCv;
  bool _powerSwitch;
  bool formOpen;
  bool serverSet;
  @override
  void initState() {
    super.initState();
    _serverIp = "192.168.1.201";
    _port =  123;
    _locoCv = 0;
    serverTextController.text = _serverIp;
    portTextController.text = (_port).toString();
    locoCvController.text = "";
    formOpen = true;
   _powerSwitch = false;
    serverSet = false;
  }

  @override
  void dispose() {
    serverTextController.dispose();
    portTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final thmeName = Provider.of<ThemeManager>(context).themeName; 
    final cColor = new CustomColors();
    return Column( 
      children:[
        Visibility(
          visible: formOpen,
          maintainState: true,
          maintainAnimation: true,
          child:Container(
          height: 90,
          child: Form(
            key:_serverFormKey,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: new EdgeInsets.fromLTRB(15, 16, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.5-15,
                    child: TextFormField(     
                      cursorWidth: 2.0,
                      controller: serverTextController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(horizontal:12),
                        hintText: 'Host IP Address',
                        labelText: 'Command Station IP',
                        //filled: true,
                      ),
                      onChanged: (text) {
                        setState(() {
                          _serverIp = text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'IP Address Missing';
                        }else if(!validator.ip(value)){
                          return 'Invalid IP';
                        }
                        return null;
                      },                       
                    ),
                  ),              
                  Container(
                    margin: new EdgeInsets.fromLTRB(5, 16, 5, 0),  
                    width: MediaQuery.of(context).size.width * 0.20-10,                  
                    child:TextFormField(
                        cursorWidth: 2.0,
                        controller: portTextController,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(horizontal:12),
                          hintText: 'Port',
                          labelText: 'Port',
                        ),
                        onChanged: (text) {
                          setState(() {
                            _port = (text=="") ? 0 :int.parse(text);
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Port Missing';
                          }
                          return null;
                        },        
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.fromLTRB(0, 16, 10, 0),
                    width: MediaQuery.of(context).size.width * 0.30-10,
                    child: RaisedButton(
                      child: Text(connectText),
                      padding: EdgeInsets.all(16.0),
                      onPressed: () {                
                        setState(() {
                          if(!serverSet){  
                            if (_serverFormKey.currentState.validate()) {   
                              print("IN CONNECT =>"+connectText); 
                              widget.setOdServerDetails(_serverIp, _port);
                              serverSet=true;
                              connectText = "Disconnect";
                              //Toast.show("Command Station Connected $serverSet", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            }
                            
                            if(_serverIp.isEmpty){
                              Toast.show("Command Station IP is missing", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            }else if(!validator.ip(_serverIp)){
                              Toast.show("Error Command Station IP", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            }else if(_port == 0){
                              Toast.show("Port is missing", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            }  
                          }else{                 
                            serverSet=_powerSwitch=false;
                            widget.togglePower(0);
                            widget.disconnectServer();
                            connectText = "Connect";
                            Toast.show("Command Station Disconnected $serverSet", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                          }
                        });        
                      },
                    ),
                  ),
                ]
            ),
          ),
        ),
                          ),
        Container(  
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: new EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: MediaQuery.of(context).size.width * 0.2,
                child: Switch(
                  value: _powerSwitch,
                  onChanged: (value) {
                    if(serverSet){
                      setState(() {
                        if(value){
                          widget.togglePower(1);
                        }else{
                          widget.togglePower(0);
                        }
                        _powerSwitch = value;
                      });
                    }else{                     
                      Toast.show("Connect to Command Station First",
                        context, duration: Toast.LENGTH_LONG, gravity:Toast.BOTTOM);                                                 
                    }
                  },
                  activeTrackColor: Colors.red[70], 
                  activeColor: Colors.red,
                  activeThumbImage: ExactAssetImage("assets/images/powerOn.png", scale: 3),
                  inactiveThumbImage: ExactAssetImage("assets/images/powerOff.png", scale: 3),
                ),            
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.62,
                child:Form(
                  key: _cvFormKey,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextFormField(
                        cursorWidth: 2.0,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Loco CV',
                          labelText: 'Loco ID',
                          contentPadding: new EdgeInsets.symmetric(horizontal:12),
                          ),
                        controller: locoCvController,
                        onChanged: (text) {
                          setState(() {
                            _locoCv = int.parse(locoCvController.text);
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly                
                        ],                  
                        validator: (value){
                          if (value.isEmpty) {
                            return 'CV Missing';
                          }else if(value =='0'){
                            return 'No Zero allowed ';
                          }
                          return null;
                        }, 
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.fromLTRB(5, 10, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.37-5,
                      child: RaisedButton(
                        child: Text(acquireText),
                        padding: EdgeInsets.all(16.0),
                        onPressed: () {
                          setState(() {
                            if(acquireText == "Acquire"){ 
                              if (_cvFormKey.currentState.validate()) {
                                widget.setLoco(_locoCv);
                                acquireText = "Release";
                                Toast.show("Locomotive Acquired", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                              }else{
                                if(locoCvController.text.isEmpty){
                                  Toast.show("CV is missing", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }else if(_locoCv == 0){
                                  Toast.show("CV should be Non Zero Number", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }
                              }
                            }else{
                              widget.setLoco(0);
                              acquireText = "Acquire";
                              locoCvController.text = 0.toString();
                              Toast.show("Locomotive Released", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ),
              ),
              Container(
                  margin: new EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.18,
                  child: IconButton(
                    iconSize: 32.0,
                    hoverColor: Colors.white60,
                    padding: EdgeInsets.all(0),
                    color: cColor.getSingleColor(thmeName, 'iconColor'),
                    icon: Icon(
                      formOpen ?  Icons.arrow_circle_up : Icons.arrow_circle_down,                        
                    ),
                    onPressed: ()=>{
                      setState((){                                                             
                        formOpen = formOpen ? false : true;                           
                      }),
                    },
                  )
              )
            ]
          ),
        ),
      ],
    );
  }

}
// !IMPORTANT Helpers to pass functions to Throttle parent
typedef odServerCallback = Function(String ip, int port);
typedef disconnectCallback = Function();
typedef setPowerCallback = Function(int pow);
typedef setCVCallback = Function(int cv);

//typedef serverFormToggleCallback = Function(bool frm);

/* Scaffold.of(context).showSnackBar(
  SnackBar(
    content: Text('Host IP Missing'),
  )
);

*/