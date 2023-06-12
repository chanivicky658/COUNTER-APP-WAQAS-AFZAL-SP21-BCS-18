import 'package:flutter/material.dart';
import 'package:ludo_flutter/ludo_provider.dart';
import 'package:ludo_flutter/twoplayer.dart';
import 'package:ludo_flutter/widgets/board_widget2.dart';
import 'package:ludo_flutter/widgets/dice_widget2.dart';

import 'package:provider/provider.dart';
class fourScreen extends StatelessWidget {
  const fourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BoardWidget(),
                Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: DiceWidget(),
                    )),
              ],
            ),
            Consumer<two_player>(
              builder: (context, value, child) => value.winners.length == 3
                  ? Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/thankyou.gif"),
                      const Text("Thank you for playing 😙", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
                      Text("The Winners is: ${value.winners.map((e) => e.name.toUpperCase()).join(", ")}", style: const TextStyle(color: Colors.white, fontSize: 30), textAlign: TextAlign.center),
                      const Divider(color: Colors.white),
                      const Text("This game made with Flutter by Faheem,Shoaib and Waqas", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      const Text("Refresh your browser to play again", style: TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
