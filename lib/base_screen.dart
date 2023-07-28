import 'package:dx_shell/dx_shell.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final String? activeNode;
  const BaseScreen({
    super.key,
    required this.activeNode,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  /// dxshellcontroller will be initialized in the init
  late DxShellController dxShellController;
  @override
  void initState() {
    // creating nodes based on all the possible paths/ nav items
    List<DxNode> nodes = List.generate(
        10, (index) => DxNode(name: "navgation-option-${index + 1}"));

    // initializing the controller with created nodes and also assign the active node from URL
    dxShellController = DxShellController(
      nodes: nodes,
      activeNode: widget.activeNode,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('example'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            /// this will notify whenever the active navigation item is changed
            DxShellObserver(
                // make sure to bind the same controller that we initialized above
                dxShellController: dxShellController,
                // will get the latest active index in the builder
                builder: (context, activeIndex) {
                  return Container(
                    height: size.height,
                    width: size.width * 0.25,
                    color: Colors.deepPurpleAccent,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return _navOption(index, index == activeIndex);
                      },
                    ),
                  );
                }),
            SizedBox(
              height: size.height,
              width: size.width * 0.75,
              child: DxPageView(
                // make sure to bind the same controller that we initialized above
                dxShellController: dxShellController,
                // children will be list of widgets in the same order as defined in dxnodes
                children: List.generate(
                  10,
                  (index) => Container(
                    height: size.height,
                    width: size.width * 0.75,
                    child: Center(
                      child: Text("navgation-option-${index + 1}"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navOption(int index, bool isSelected) {
    return InkWell(
      onTap: () => dxShellController.animateToNode(index),
      child: Container(
        height: 50,
        color: isSelected ? Colors.blue : Colors.transparent,
        child: Text(
          'navgation-option-${index + 1}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
