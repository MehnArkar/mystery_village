
import 'package:flutter/material.dart';

class AttackButton extends StatelessWidget {
  final VoidCallback onPressedAttack;
  const AttackButton({super.key,required this.onPressedAttack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:const Color(0x88ffffff),
          minimumSize:const Size(120, 120),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))
        ),
        onPressed: onPressedAttack,
        child: Image.asset('assets/images/attack_icon.png',width: 60,color:const Color(0xccffffff),)
    );
  }
}
