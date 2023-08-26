import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness:Brightness.light,
            seedColor: Colors.green,
            primary: Colors.green,
          secondary: Colors.white,

        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mail and SMS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int selected=0;

  var number=TextEditingController();
  var mailId=TextEditingController();
  var message=TextEditingController();
  var subject=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      selected=index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selected==index?Theme.of(context).primaryColorLight:null,
                      border:Border.all(color: Theme.of(context).textTheme.bodyMedium!.color!)
                    ),
                    child: Text(index==0?"Mail":"SMS"),),
                ),
              ))
            ),
            selected==1?textFieldCustome(controller: number, hint: "Enter Number",type: TextInputType.number):Container(),
            selected==1?Container():textFieldCustome(controller: mailId, hint: "Mail Id",type: TextInputType.number),
            selected==1?Container():textFieldCustome(controller: subject, hint: "Subject",type: TextInputType.number),
            textFieldCustome(controller: message, hint: "Message",type: TextInputType.number),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                ),
                onPressed: (){
                  selected==0
                      ?launchUrl(Uri.parse("mailto:${mailId.text}?subject=${subject.text}&body=${message.text}"))
                      :launchUrl(Uri.parse("sms:+91${number.text}?body=${message.text}"));
                }, child: Text(selected==0?"Send Mail":"Send SMS",style: Theme.of(context).textTheme.bodyText1,))
          ],
        ),
      ),
     );
  }

  textFieldCustome({required TextEditingController controller,required String hint,TextInputType? type}){
    return     Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).cardColor)
          ),

        ),
      ),
    );
  }

}
