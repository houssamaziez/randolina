import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
 
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:randolina/const.dart';
  Future<void> send(BuildContext context,subjectController, name, email, pathfile,  ) async {
    if (Platform.isIOS) {
      final bool canSend = await FlutterMailer.canSendMail();
      if (!canSend) {
        const SnackBar snackbar =
            SnackBar(content: Text('no Email App Available'));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }
    
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    final MailOptions mailOptions = MailOptions(
      body:  '''  <em>hi <code> ${ name}</code></em> <br><br><br>
  <strong>This is a message confirming your registration with us</strong>
  ''',
      subject: subjectController.text,
      recipients: <String>[ email],
      isHTML: true,
      // bccRecipients: ['other@example.com'],
      // ccRecipients: <String>['third@example.com'],
      attachments: [ pathfile],
    );

    String platformResponse;

    try {
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      switch (response) {
        case MailerResponse.saved:
          platformResponse = 'mail was saved to draft';
          break;
        case MailerResponse.sent:
          platformResponse = 'mail was sent';
          break;
        case MailerResponse.cancelled:
          platformResponse = 'mail was cancelled';
          break;
        case MailerResponse.android:
          platformResponse = 'intent was success';
          break;
        default:
          platformResponse = 'unknown';
          break;
      }
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
     
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Message',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(error.message ?? 'unknown error'),
            ],
          ),
          contentPadding: const EdgeInsets.all(26),
          title: Text(error.code),
        ),
      );
    } catch (error) {
      platformResponse = error.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
     
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }
   generatePdf(  context) async {
    final doc = pw.Document();
final image = await imageFromAssetBundle('images/pw.jpg');
 final TextEditingController _bodyController = TextEditingController(
      text: '''  <em>hi   <code>HTML</code></em> <br><br><br>
  <strong>Some Apps like Gmail might ignore it</strong>
  ''');
    final TextEditingController _subjectController =
      TextEditingController(
        
        text: 'the Subject');
doc.addPage(pw.Page(
      build: (pw.Context context) {

        return  pw.Stack(children: [


       pw.   SizedBox(width: double.infinity),
       pw.Container(width: double.infinity,height: double.infinity,
          child: pw.Image(image, fit: pw.BoxFit.cover),
        ),
       pw.Column(children: [
        pw.Spacer(),
       pw. Align(
        alignment:pw.Alignment.topLeft,
        child:  pw.Center(child:  pw.Text("Acceptance Certificate", style:pw.TextStyle(fontSize: 40)),),),
        pw.Spacer(),
        pw. Center(child:  pw.Text("name",style:pw.TextStyle(fontSize: 30)),),
    
       pw. Center(child:  pw.Text("Acceptance Certificate"),),
        pw.Spacer(flex: 4),
       ])
        ]);
        
        
         // Center
      }));
        final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
await file.writeAsBytes(await doc.save());
    send(context, _subjectController,  "houssam"," houssamaziez@gmail.com", file.path,  );

 
  }


class Screensend extends StatefulWidget {
    final String name, email, nameofclub ;

  const Screensend({super.key, required this.name, required this.email, required this.nameofclub, });

  @override
  State<Screensend> createState() => _MyAppState();
}

class _MyAppState extends State<Screensend> {
  var file;

  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
        appBar: AppBar(
          
          title: Text(widget. name), actions: [IconButton(onPressed:  (){
          final TextEditingController _subjectController =
      TextEditingController(text: 'the Subject');
if (file!=null) {
    send(context, _subjectController, widget.name,widget.email, file.path,  );
  
}}, icon: Icon(Icons.send, ),)

],),
        body: PdfPreview(
          
          allowPrinting: false,allowSharing: false, canChangeOrientation: false,
        canChangePageFormat: false,loadingWidget: spinkit,
          build: (format) => _generatePdf(format, widget. name,context,widget. name,widget. email,widget. nameofclub),
        ),
      ) ;
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title,context  , name ,email , nameofclub) async {
    final doc = pw.Document();
final image = await imageFromAssetBundle('images/pw.jpg');
 final TextEditingController _bodyController = TextEditingController(
      text: '''  <em>hi   <code>HTML</code></em> <br><br><br>
  <strong>Some Apps like Gmail might ignore it</strong>
  ''');
    final TextEditingController _subjectController =
      TextEditingController(text: 'the Subject');
doc.addPage(pw.Page(margin:pw.EdgeInsets.all(0) ,
      build: (pw.Context context) {

        return  pw.Stack(children: [


       pw.   SizedBox(width: double.infinity),
       pw.Container(width: double.infinity,height: double.infinity,
          child: pw.Image(image, fit: pw.BoxFit.contain),
        ),
       pw.Column(children: [
        pw.Spacer(),
        pw.Spacer(),
       pw. Align(
        alignment:pw.Alignment.topLeft,
        child:  pw.Center(child:  pw.Text("Acceptance Certificate", style:pw.TextStyle(fontSize: 40)),),),
        pw.Spacer(flex: 3),
          pw.Padding(
          padding:   pw.EdgeInsets.only(left: 45, right: 45) ,
          child:pw. Center(child:  pw.Text("Hello $name, you have been accepted into this event. Thank you for your participation",style:pw.TextStyle(fontSize: 30,),
        textAlign: pw.TextAlign.center)
        
        ,), ), 
    
        pw.Spacer(flex: 4),
          pw.Padding(
          padding:   pw.EdgeInsets.only(left: 0, bottom: 0) ,
          child:pw. Center(child:  pw.Text("Club ",style:pw.TextStyle(fontSize: 20),
        textAlign: pw.TextAlign.center)
        
        ,), ),
         pw.Padding(
          padding:   pw.EdgeInsets.only(left: 0, bottom: 30) ,
          child:pw. Center(child:  pw.Text("$nameofclub ",style:pw.TextStyle(fontSize: 20),
        textAlign: pw.TextAlign.center)
        
        ,), ),
       ])
        ]);
         // Center
      }));
        final output = await getTemporaryDirectory();
    file = File("${output.path}/example.pdf");
await file.writeAsBytes(await doc.save());
setState(() {
  
});
  return doc.save();
  }
}