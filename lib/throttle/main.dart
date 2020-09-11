import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:toast/toast.dart';
import 'package:wifi/wifi.dart';
import 'theappbar.dart';
import 'dart:async';
import 'dart:io';
import 'functionbtns.dart';
import 'odserver.dart';
import 'knob.dart';



class ThrottlePage extends StatefulWidget {
  ThrottlePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ThrottlePageState createState() => _ThrottlePageState();
}

class _ThrottlePageState extends State<ThrottlePage> {

  int             _cv;
  int             _speed;
  int             _direction;
  String          _server;
  int             _port;
  int             _power;
  String          _localIP;

  InternetAddress   _address;
  RawDatagramSocket _udpSocket;
  bool formClose;
  bool isCSSet;
  bool isLocoSet;
  bool isPowOn;

  @override
  void initState(){
    super.initState();
    setState(() {
      _server= "0.0.0.0";
      _port = 0000;
      _cv = 0;
      _speed = 0;
      _direction = 1;
      _power = 0;
      _address = InternetAddress(_server);
      formClose = true;  
      isCSSet = false;
      isLocoSet = false; 
      isPowOn = false; 
    });
    initPlatformState();
  }

  bool allSet(){
    if(isCSSet && isLocoSet && isPowOn){    
      print("Everything is ready:\n");
      return true;
    }else{
      print("The following are not ready:\n "+
      ((!isCSSet) ? '=> Command station not Set':'Command station Set')+"\n "+
      ((!isCSSet) ? '=> Locomotive not Set':'Locomotive Set')+"\n"+
      ((!isCSSet) ? '=> Power Switched OFF':'Power Switched ON'));
      return false;
    }
  }

//This Function provides local IP address i.e. Mobile
  Future<InternetAddress> get selfIP async {
      String ip = await Wifi.ip;
      print('WIFI PLUGIN The Local IP is: $ip');
      return InternetAddress(ip);
  }
  Future<void> initPlatformState() async {
    String ipAddress = "Unknown";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipAddress;

      Toast.show('The Local IP is: $ipAddress', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }
    if (!mounted) return;

    setState(() {
      _localIP = ipAddress;
      print('The Local IP is: $_localIP');
    });
  }

/* Currently, temporarily, the following functions will use 
 * a UDP socket and send commands to ESP connected to 
 * UNO or MEGA. Needs to be implemented according to Protocol. */

// IOS InternetAddress.anyIPv4 //Android _localIP //Endpoint.any(port: Port(4333))

/* Currently, temporarily, the following functions will use 
 * a UDP socket and send command packets to ESP connected to 
 * UNO or MEGA. Needs to be implemented according to our Protocol. */

  void setSocket(){
     new Timer(const Duration(milliseconds: 200), () {
      
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((RawDatagramSocket socket){      
        setState(() {
          _udpSocket = socket;
        });
        print('Datagram socket ready at ${socket.address.address}:${socket.port}');
        Toast.show('Datagram socket ready at: ${socket.address.address}:${socket.port}',
                context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      });
    });
  }

  void connectToUDP(){   
    new Timer(const Duration(milliseconds: 800), () {
      try{           
        var tb = _udpSocket.send("Connection Success".codeUnits, _address, _port);
        
        if(tb == 0){
          Toast.show("Error occured. Could not send Data to UDP", 
          context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          //_udpSocket.close();
        }else{
          Toast.show("Connection Success. Total Bytes Sent $tb", 
          context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          print("UDP SAMPLE PACKET SENT");
        }

      }
      catch(e){
        Toast.show("Error occurred. Could not Connect to Server",
        context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print("_________________________________________________________");
        print(e);
      }
    });

  }

  void sendCommandToStation(cmd){ 

    if(allSet()){ 
      try{  
        var tb = _udpSocket.send(cmd.codeUnits, _address, _port);
        print("Total Bytes Sent $tb");
        if(tb == 0){
          Toast.show("Connection Error. Could not send Command to Server..", 
                  context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        }else{
          Toast.show(cmd, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }            
      }
      catch(e){ 
        print("_________________________________________________________");
        print(e);
        Toast.show("Connection Error. Could not send Command to Server:\n $e", 
                  context, duration:  Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }  
    }

    Toast.show('Server Details:\n IP:  $_server, \n Port: $_port, \n Loco CV: $_cv \nCommand:=> \n<t 1  $_cv $_speed $_direction>',
                  context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);         

  }

  void sendFunctionCommandToStation(val){
      try{  
        var tb = _udpSocket.send(val.codeUnits, _address, _port);

        print("Total Bytes Sent $tb");
        if(tb == 0){
          Toast.show("Connection Error. Could not send Function Command to Server..", 
                        context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          //_udpSocket.close();
        }else{
          Toast.show('Command => : '+val, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          print(val);
        }        
      }
      catch(e){ 
        print("_________________________________________________________");
        print(e);
        Toast.show("Connection Error. Could not send Function Command to Server:\n $e", 
                  context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }  
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: TheAppBar(title: " MThrottle"),
       body: Builder(
        builder: (context) =>
        SingleChildScrollView(
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    DccServer(
                        setOdServerDetails : (String ip, int port){         
                          //Toast.show(_udpSocket.toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);                   
                          print(_udpSocket);
                          if (_udpSocket != null) {
                            _udpSocket.close();
                             setSocket();
                          }else{
                            setSocket();
                          }                          
                          setState(() {
                            _server   = ip;
                            _port     = port;
                            _address  = InternetAddress(ip); 
                             isCSSet  = true;
                          });
                          connectToUDP();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('SET:=> \nServer: $ip, \nPort: $port'),
                            )
                          );
                          print("IP $ip SET"); 
                        },                       
                        disconnectServer: (){
                          setState(() {
                            isCSSet = false;                        
                            _udpSocket.close();
                            Toast.show('Server Disconnected', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);                   
                          });
                        },
                        togglePower : (int pow){                          
                          if(isCSSet){
                            String cmd = "<"+pow.toString()+">";
                            setState(() {
                              _power = pow;                        
                              sendFunctionCommandToStation(cmd); 
                              if(_power==1){
                                isPowOn = true;
                              }else{
                                isPowOn = false;
                              }                             
                            });
                            print(cmd);
                          }
                        },
                        setLoco: (int cv){
                          setState(() {
                            _cv = cv;
                            if(_cv !=0){                                 
                              isLocoSet = true;
                            }else{
                              isLocoSet = false;
                            }
                          });
                        },                     
                    ),
                      
                      Container(
                        child: Column(
                          children: [
                            ThrottleKnob(
                              serverStatus: isCSSet,
                              setThrottleDetails: (int dir, int speed){ 
                                if(allSet()){
                                  setState(() { 
                                    _direction = dir;
                                    _speed = speed;
                                    String cmd = "<t 01 $_cv $_speed $_direction>";
                                    sendCommandToStation(cmd);
                                    print(cmd);
                                  });
                                }
                              },

                              /*serverFormClose: (bool close){
                                setState(() {
                                  formClose = close;
                                });                        
                              },*/
                            ),
                            FunctionButtons(
                              sendFunction: (String func){              
                                if(allSet()){
                                  String cmd = "<f $_cv $func>";    
                                  setState(() {                           
                                    sendFunctionCommandToStation(cmd);
                                    print(cmd);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                  ]
                ),
        ),
       ),
     ); 
  }
}

