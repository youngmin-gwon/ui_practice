import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/widgets/custom_text.dart';

class DriversTable extends StatelessWidget {
  const DriversTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGray.withOpacity(.1),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              SizedBox(width: 10),
              CustomText(
                text: "Available Drivers",
                color: lightGray,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('Location'),
                ),
                DataColumn(
                  label: Text('Rating'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(
                  7,
                  (index) => DataRow(cells: [
                        const DataCell(CustomText(text: "Santos Enoque")),
                        const DataCell(CustomText(text: "New York City")),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.deepOrange,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            CustomText(text: "4.$index")
                          ],
                        )),
                        DataCell(Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: active, width: .5),
                              color: light,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: CustomText(
                              text: "Block Driver",
                              color: active.withOpacity(.7),
                              fontWeight: FontWeight.bold,
                            ))),
                      ]))),
        ],
      ),
    );
  }
}
