import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_ui_challenge/pdf/model/product.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  const CustomRow({
    required this.itemName,
    required this.itemPrice,
    required this.amount,
    required this.total,
    required this.vat,
  });
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            "Hello world!",
          ),
        ),
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> createInvoice(List<Product> soldProducts) async {
    // create a pdf document
    final pdf = pw.Document();
    // create a list of "CustomRow" which contains each row of the itme list
    final List<CustomRow> elements = [
      const CustomRow(
        itemName: "ItemName",
        itemPrice: "ItemPrice",
        amount: "Amount",
        total: "Total",
        vat: "VAT",
      ),
      for (final product in soldProducts)
        CustomRow(
          itemName: product.name,
          itemPrice: product.price.toStringAsFixed(2),
          amount: product.amount.toStringAsFixed(2),
          total: (product.price * product.amount).toStringAsFixed(2),
          vat: (product.vatInPercent / 100 * product.price).toStringAsFixed(2),
        ),
      CustomRow(
        itemName: "Sub Total",
        itemPrice: "",
        amount: "",
        total: "",
        vat: "${getSubTotal(soldProducts)} EUR",
      ),
      CustomRow(
        itemName: "VAT Total",
        itemPrice: "",
        amount: "",
        total: "",
        vat: "${getVatTotal(soldProducts)} EUR",
      ),
      CustomRow(
        itemName: "Total",
        itemPrice: "",
        amount: "",
        total: "",
        vat:
            "${(double.parse(getSubTotal(soldProducts)) + double.parse(getVatTotal(soldProducts))).toStringAsFixed(2)} EUR",
      ),
    ];
    // load the image via rootBundle
    final image =
        (await rootBundle.load("assets/flutter.png")).buffer.asUint8List();
    // add a page to the PDF and add one by one the elements
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Image(pw.MemoryImage(image),
                  width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Customer Name"),
                      pw.Text("Customer Address"),
                      pw.Text("Customer City"),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("Max Weber"),
                      pw.Text("Weird Street Name 1"),
                      pw.Text("77662 Not my City"),
                      pw.Text("Vat-id: 123456"),
                      pw.Text("Invoice-Nr: 00001")
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                  "Dear Customer, thanks for buying at Flutter Explained, feel free to see the list of items below."),
              pw.SizedBox(height: 25),
              itemColumn(elements),
              pw.SizedBox(height: 25),
              pw.Text("Thanks for your trust, and till the next time."),
              pw.SizedBox(height: 25),
              pw.Text("Kind regards,"),
              pw.SizedBox(height: 25),
              pw.Text("Max Weber")
            ],
          );
        },
      ),
    );
    // Save the PDF and return the Uint8List
    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text(element.itemName,
                        textAlign: pw.TextAlign.left)),
                pw.Expanded(
                    child: pw.Text(element.itemPrice,
                        textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.amount, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.total, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child: pw.Text(element.vat, textAlign: pw.TextAlign.right)),
              ],
            )
        ],
      ),
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    // create a temporary folder to store a file
    // reference: path_provider
    final output = await getTemporaryDirectory();
    // create a filepath where you want to save it
    final filePath = "${output.path}/$fileName.pdf";
    // create a file instance with the filepath
    final file = File(filePath);
    // write into the file the byteArray
    await file.writeAsBytes(byteList);
    // open the document with OpenDocument
    await OpenDocument.openDocument(filePath: filePath);
  }

  String getSubTotal(List<Product> products) {
    return products
        .fold(
            0.0,
            (double previousValue, element) =>
                previousValue + (element.amount * element.price))
        .toStringAsFixed(2);
  }

  String getVatTotal(List<Product> products) {
    return products
        .fold(
            0.0,
            (double prev, next) =>
                prev + ((next.price / 100 * next.vatInPercent) * next.amount))
        .toStringAsFixed(2);
  }
}
