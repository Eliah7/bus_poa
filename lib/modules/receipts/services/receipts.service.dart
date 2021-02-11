import 'package:bfast/bfast.dart';
import 'package:bfastui/bfastui.dart';
import 'package:bus_poa/modules/receipts/services/printer.service.dart';
import 'package:bus_poa/modules/receipts/states/receipts.state.dart';

class ReceiptsService {
  final serverUrl = "https://buspoa.co.tz/buspoa/website/Payment/getTicketJson";
  final printerService = PrinterService();

  Future fetchReceiptDetails(String receipt) async {
    return await BFast.functions().request(serverUrl + "/" + receipt).get();
  }

  Future printReceipt(Map<String, dynamic> receipt) async {
    String receiptToPrint = "";
    receiptToPrint += '-------------------------------\n';
    receiptToPrint += (DateTime.now().toUtc().toString()) + '\n-------------------------------\n';
    
    receiptToPrint += '-------------------------------\n';
    receiptToPrint += "\t\t\t BUS POA" + '\n-------------------------------\n';

    // receipt.entries.forEach((element) {
      receiptToPrint += "Trip Route Name : "+ receipt["trip_route_name"].toString() + "\n";
      receiptToPrint += "Depature Date : "+ receipt["assign_date"].toString()  + "\n";
      receiptToPrint += "Passenger Name : "+ receipt["passenger_name"].toString()  + "\n";
      receiptToPrint += "Seat No : "+ receipt["seat_numbers"].toString() + "\n";
      receiptToPrint += "Pick up Point: "+ receipt["pickup_trip_location"].toString()  + "\n";
      receiptToPrint += "Drop Point : "+ receipt["drop_trip_location"].toString()  + "\n";
      receiptToPrint += "Ticket No : "+ receipt["id_no"].toString()  + "\n";
      receiptToPrint += "Price: "+ receipt["price"].toString() + "\n";
      receiptToPrint += "TRA VFD: "+ receipt["tra_vfd"].toString() + "\n";
      // receiptToPrint += "Phone No : "+ "\n";

          // receiptToPrint += element.key.toString() + " : " + element.value.toString() + "\n";
    // });

    printerService
        .posPrint(
            data: receiptToPrint, id: receipt["id_no"], qr: receipt["id_no"]);
  }
}
