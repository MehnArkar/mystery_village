import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mystery_village/game/mystery_village_game.dart';
import 'package:mystery_village/helper/attack_button.dart';
import 'package:mystery_village/helper/constants.dart';

import 'helper/joypad.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  MysteryVillageGame game = MysteryVillageGame();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GameWidget(game: game),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: AttackButton(onPressedAttack: onPressAttack,),
            ),
          )
        ],
      ),
    );
  }

  onJoypadDirectionChanged(Direction direction){
      game.onDirectionChange(direction);
  }

  onPressAttack(){
    game.onPressedAttack();
  }
}
