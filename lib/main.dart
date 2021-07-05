    import 'package:flutter/material.dart';
    import 'package:font_awesome_flutter/font_awesome_flutter.dart';
    import 'package:http/http.dart'as http;
    import 'dart:convert';



   void main () => runApp(
      MaterialApp(
         title: "Weather App",
         home: Home(),
      )
   );


   class Home extends StatefulWidget{
      @override
      State<StatefulWidget> createState () {
         return HomeState();
      }
   }

   class HomeState extends State<Home> {

     var temp;
     var description;
     var currently;
     var humidity;
     var windspeed;


     Future getWeather () async {
      http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Abuja&units=imperial&appid=a848ef6b8b6d109e7ab03fb4489f7c4a'));
       var results = jsonDecode(response.body);
       setState(() {
         this.temp = results['main'] ['temp'];
         this.description= results ['weather'][0]['main'];
         this.currently = results['weather'][0]['main'];
         this.windspeed =results['wind']['speed'];

       });
     }

     @override
     void initState () {
       super.initState();
       this.getWeather();

     }

      @override
      Widget build (BuildContext context) {
         return Scaffold(
            body: Column(
               children: <Widget>[
                  Container(
                     height:MediaQuery. of(context).size.height /3,
                     width: MediaQuery. of(context).size.width,
                     color: Colors.blue,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment:CrossAxisAlignment.center ,
                       children: <Widget> [
                         Padding(
                             padding: EdgeInsets.only(bottom: 10.0),
                                 child: Text(
                                   "Currently in Abuja",
                                   style: TextStyle(
                                     color: Colors.lightBlueAccent,
                                     fontSize: 14.0,
                                     fontWeight: FontWeight.w600
                                   ),
                                 ),
                               ),
                               Text(
                                 temp != null? temp.toString() +"\u00B0" : "loading",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 40.0,
                                   fontWeight: FontWeight.w600
                                 ),
                               ),
                         Padding(
                           padding: EdgeInsets.only(top: 10.0),
                           child: Text(
                             currently != null ? currently.toString() : "loading",
                             style: TextStyle(
                                 color: Colors.lightBlueAccent,
                                 fontSize: 14.0,
                                 fontWeight: FontWeight.w600
                                   ),
                                 ),
                               ),
                             ],
                           )
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ListView(
                                children: <Widget>[
                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                                    title: Text("Temperature"),
                                    trailing: Text(temp!=null ? temp.toString()+"\u00B0": "loading"),
                                  ),
                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.cloud),
                                    title: Text("Weather"),
                                    trailing: Text( description!=null ? description.toString():"loading"),
                                  ),
                                  ListTile(
                                  leading: FaIcon(FontAwesomeIcons.sun),
                                  title: Text("Humidity"),
                                  trailing: Text(humidity!=null ? humidity.toString() : "loading"),
                            ),
                                 ListTile(
                                  leading: FaIcon(FontAwesomeIcons.wind),
                                  title: Text("Wind speed"),
                                  trailing: Text(windspeed!= null? windspeed.toString(): "loading"),
                           ),
                          ],
                        ),
                     )
                  )
               ]
            )
              );
            }
         }