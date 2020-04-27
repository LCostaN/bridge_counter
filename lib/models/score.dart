class Score {
  int bonus = 0;
  int under = 0;
  int under2 = 0;

  Score(this.under, this.under2, this.bonus)
      : assert(under == 0 || under2 == 0);
}
