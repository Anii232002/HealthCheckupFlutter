class TestItemModel {
  final String title;
  final int delivery_time;
  final int price;
  final int prev_price;
  final int no_of_tests;
  bool isSelected;

  TestItemModel(
      {required this.title,
      required this.delivery_time,
      required this.prev_price,
      required this.price,
      required this.no_of_tests,
      required this.isSelected});
}
