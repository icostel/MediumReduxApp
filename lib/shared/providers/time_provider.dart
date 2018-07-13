class TimeProvider {
  const TimeProvider();

  DateTime get now => DateTime.now();

  int get year => DateTime.now().year;
}
