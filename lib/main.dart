import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/src/interface.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String title  = "Amit Hassan";


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, title),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _print(context, toFutureOr, PdfPageFormat.standard);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FutureOr<Uint8List> toFutureOr(PdfPageFormat format) async {
    return _generatePdf(format, title);
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> _print(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
      ) async {
    List printerList = await PrintingPlatform.instance.listPrinters();
    bool result = await  PrintingPlatform.instance.layoutPdf(
      printerList.first,
      build,
      "Document",
      pageFormat,
      false,
      false,
    );
   /* final data = PdfPreviewController.of(context);

    try {
      final result = await Printing.layoutPdf(
        onLayout: _generatePdf(PdfPageFormat.standard, title),
        //name: jobName,
        //format: data.actualPageFormat,
        //dynamicLayout: dynamicLayout,
        //usePrinterSettings: usePrinterSettings,
      );

      if (result) {
        onPrinted?.call();
      }
    } catch (exception, stack) {
      InformationCollector? collector;

      assert(() {
        collector = () sync* {
          yield StringProperty('PageFormat', data.actualPageFormat.toString());
        };
        return true;
      }());

      FlutterError.reportError(FlutterErrorDetails(
        exception: exception,
        stack: stack,
        library: 'printing',
        context: ErrorDescription('while printing a PDF'),
        informationCollector: collector,
      ));

      onPrintError?.call(exception);
    }*/
  }
}
