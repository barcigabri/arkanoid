import 'package:arkanoid/arkanoid_game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

class PlayButton extends TextComponent with Tappable {
  final ArkanoidGame game;


  PlayButton(this.game) : super (
    text: "PLAY",
    position: Vector2(game.screen.x/2,game.screen.y*3/4 + game.tileSize.y*2),
    //size: Vector2(game.playScreenSize.x*4/5,game.playScreenSize.x*4/5*45/8),
    textRenderer: game.getPainter(20),
  ) {
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo event) {
    textRenderer = game.getPainter(30);
    return true;
  }

  @override
  bool onTapUp(TapUpInfo event) {
    tapped();
    return true;
  }

  @override
  bool onTapCancel() {
    textRenderer = game.getPainter(20);
    return true;
  }

  void tapped() {
    textRenderer = game.getPainter(20);
    switch(game.selectorEye.eye) {
      case 1: // Left penalized
        game.addPenalization(true);
        break;
      case 2: // No penalization
        game.removeEyeSelection();
        game.startGame();
        break;
      case 3: // Right penalized
        game.addPenalization(false);
        break;
    }
  }

  void keyboardAction(RawKeyEvent event) {
    if(event.logicalKey == LogicalKeyboardKey.gameButtonA || event.logicalKey == LogicalKeyboardKey.gameButtonStart|| event.logicalKey == LogicalKeyboardKey.keyA) {
      if (event is RawKeyDownEvent) {
        textRenderer = game.getPainter(30);
      }
      if (event is RawKeyUpEvent) {
        tapped();
      }
    }
  }

}
