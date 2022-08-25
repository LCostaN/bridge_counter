import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';

/// This class keeps all point calculations separate so GameState doesn't become
/// too big and also helps to separate a little of code.
class PointCalculator {
  int calculateTricks(
    int target,
    Multiplier multiplier,
    Naipe naipe,
  ) {
    target = target - 6;
    int points = 0;
    switch (naipe) {
      case Naipe.paus:
      case Naipe.ouros:
        points = 20 * target;
        break;
      case Naipe.copas:
      case Naipe.espada:
        points = 30 * target;
        break;
      case Naipe.semNaipe:
        points = (30 * target) + 10;
        break;
    }

    switch (multiplier) {
      case Multiplier.none:
        break;
      case Multiplier.double:
        points *= 2;
        break;
      case Multiplier.redouble:
        points *= 4;
        break;
    }

    return points;
  }

  int calculateUndertricks(
    int underTricks,
    Multiplier multiplier,
    bool isVulnerable,
  ) {
    int points = 0;

    switch (multiplier) {
      case Multiplier.none:
        if (isVulnerable)
          points = underTricks * 100;
        else
          points = underTricks * 50;
        break;
      case Multiplier.double:
      case Multiplier.redouble:
        while (underTricks > 0) {
          if (isVulnerable) {
            switch (underTricks) {
              case 1:
                points += 200;
                break;
              default:
                points += 300;
            }
            underTricks--;
          } else {
            switch (underTricks) {
              case 1:
                points += 100;
                break;
              case 2:
              case 3:
                points += 200;
                break;
              default:
                points += 300;
            }
            underTricks--;
          }
        }
        break;
    }

    if (multiplier == Multiplier.redouble) {
      points *= 2;
    }

    return points;
  }

  int calculateOverTricks(
    int overTricks,
    Multiplier multiplier,
    Naipe naipe,
    bool isVulnerable,
  ) {
    int points = 0;

    switch (multiplier) {
      case Multiplier.none:
        int basePoints = naipe == Naipe.paus || naipe == Naipe.ouros ? 20 : 30;
        points = overTricks * basePoints;
        break;
      case Multiplier.double:
        if (isVulnerable)
          points = overTricks * 200;
        else
          points = overTricks * 100;
        break;
      case Multiplier.redouble:
        if (isVulnerable)
          points = overTricks * 400;
        else
          points = overTricks * 200;
        break;
    }

    return points;
  }

  int calculateInsult(Multiplier multiplier) {
    switch (multiplier) {
      case Multiplier.none:
        return 0;
      case Multiplier.double:
        return 50;
      case Multiplier.redouble:
        return 100;
    }
  }

  int calculateSlam(int target, bool isVulnerable) {
    if (target == 12) {
      if (isVulnerable)
        return 750;
      else
        return 500;
    } else {
      if (isVulnerable)
        return 1500;
      else
        return 750;
    }
  }
}
