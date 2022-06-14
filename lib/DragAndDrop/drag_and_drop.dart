import 'package:flutter/material.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({Key? key}) : super(key: key);

  @override
  State<DragAndDrop> createState() => _HomeState();
}

class _HomeState extends State<DragAndDrop> {
  List<Offset> position = [];
  List<double> opacity = [];
  List<Color> colour = [];
  List<int> containers = [];
  @override
  void initState() {
    position = [
      const Offset(50, 100),
      const Offset(200, 100),
      const Offset(50, 250)
    ];
    opacity = [1.0, 1.0, 1.0];
    colour = [Colors.red, Colors.red, Colors.red];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(width: 2.0))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index >= containers.length) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: index < containers.length
                                    ? Colors.red
                                    : Colors.white,
                                border: Border.all(
                                    width: index < containers.length ? 2 : 0)),
                          ),
                        );
                      }
                      return Center(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: index < containers.length ? 1 : 0,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: index < containers.length
                                    ? Colors.red
                                    : Colors.white,
                                border: Border.all(
                                    width: index < containers.length ? 2 : 0)),
                          ),
                        ),
                      );
                    },
                    itemCount: containers.length + 1,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: position[0].dx,
              top: position[0].dy,
              child: GestureDetector(
                onLongPress: () {
                  colour[0] = Colors.blue;
                  setState(() {});
                },
                onLongPressStart: (details) {
                  colour[0] = Colors.blue;
                  setState(() {});
                },
                onLongPressUp: () {
                  colour[0] = Colors.red;
                  setState(() {});
                },
                onLongPressEnd: (details) {
                  if (details.globalPosition.dy >
                      (MediaQuery.of(context).size.height / 2)) {
                    // position = const Offset(-200, -200);
                    containers.add(0);
                    opacity[0] = 0.0;
                    setState(() {});
                  }
                },
                onLongPressMoveUpdate: ((details) {
                  position[0] = details.globalPosition - const Offset(50, 50);
                  setState(() {});
                }),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: opacity[0],
                  child: Container(
                    width: 100,
                    height: 100,
                    color: colour[0],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: position[1].dx,
              top: position[1].dy,
              child: GestureDetector(
                onLongPress: () {
                  colour[1] = Colors.blue;
                  setState(() {});
                },
                onLongPressUp: () {
                  colour[1] = Colors.red;
                  setState(() {});
                },
                onLongPressEnd: (details) {
                  if (details.globalPosition.dy >
                      (MediaQuery.of(context).size.height / 2)) {
                    // position = const Offset(-200, -200);
                    containers.add(0);
                    opacity[1] = 0.0;
                    setState(() {});
                  }
                },
                onLongPressMoveUpdate: ((details) {
                  position[1] = details.globalPosition - const Offset(50, 50);
                  setState(() {});
                }),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: opacity[1],
                  child: Container(
                    width: 100,
                    height: 100,
                    color: colour[1],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: position[2].dx,
              top: position[2].dy,
              child: GestureDetector(
                onLongPress: () {
                  colour[2] = Colors.blue;
                  setState(() {});
                },
                onLongPressUp: () {
                  colour[2] = Colors.red;
                  setState(() {});
                },
                onLongPressEnd: (details) {
                  if (details.globalPosition.dy >
                      (MediaQuery.of(context).size.height / 2)) {
                    // position = const Offset(-200, -200);
                    containers.add(0);
                    opacity[2] = 0.0;
                    setState(() {});
                  }
                },
                onLongPressMoveUpdate: ((details) {
                  position[2] = details.globalPosition - const Offset(50, 50);
                  setState(() {});
                }),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: opacity[2],
                  child: Container(
                    width: 100,
                    height: 100,
                    color: colour[2],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
