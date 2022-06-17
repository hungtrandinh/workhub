import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/drawing/drawing_provider.dart';
import 'package:workhub/ui/widgets/custom_panter.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);
  static const String routeName = "/drawing";

  @override
  State<StatefulWidget> createState() {
    return DrawingPageState();
  }
}

class DrawingPageState extends State<DrawingPage> {


  void selectColor() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Color Chooser'),
        content: SingleChildScrollView(
          child :ColorPicker(
            pickerColor:context.read<DrawingProvider>().colors,
            onColorChanged: (color) {
              Provider.of<DrawingProvider>(context,listen: false).updateColor(color);
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final points = context.watch<DrawingProvider>();
    final update =Provider.of<DrawingProvider>(context,listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(138, 35, 135, 1.0),
                  Color.fromRGBO(233, 64, 87, 1.0),
                  Color.fromRGBO(242, 113, 33, 1.0),
                ])),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: GestureDetector(
                      onPanDown: (details) {
                        final down = Provider.of<DrawingProvider>(context,listen: false);
                        down.downPosition(details);
                      },
                      onPanUpdate: (details) {
                        final update = Provider.of<DrawingProvider>(context,listen: false);
                        update.updatePosition(details);
                      },
                      onPanEnd: (details) {

                        update.endPosition();
                      },
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: LayoutBuilder(
                            builder: (context,constraints) {
                              return CustomPaint(
                                painter: MyCustomPainter(points: points.drawing),

                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width* 0.8,
                  decoration:const  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon:const  Icon(
                            Icons.color_lens,
                            color:Colors.red,
                          ),
                          onPressed: () {
                            selectColor();
                          }),
                      Expanded(
                        child: Slider(
                          min: 1.0,
                          max: 10.0,
                          label: "Stroke ${points.stroke}",
                          activeColor: points.colors,
                          value:points.stroke,
                          onChanged: (double value) {
                            Provider.of<DrawingProvider>(context,listen: false).updateStroke(value);

                          },
                        ),
                      ),
                      IconButton(
                          icon:const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Provider.of<DrawingProvider>(context,listen: false).delete();

                          }),
                      IconButton(
                          icon:const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Provider.of<DrawingProvider>(context,listen: false).setStateDrawing();

                          }),
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
