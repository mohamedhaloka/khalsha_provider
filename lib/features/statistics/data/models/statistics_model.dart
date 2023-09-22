class StatisticsModel {
  StatisticsModel({
    this.totalProfit,
    this.totalProfitToday,
    this.totalProfitMonth,
    this.totalProfitWeek,
    this.totalProfitYear,
  });

  String? totalProfit;
  String? totalProfitToday;
  String? totalProfitMonth;
  String? totalProfitWeek;
  String? totalProfitYear;

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
        totalProfit: json['total_profit'].toString(),
        totalProfitToday: json['total_profit_today'].toString(),
        totalProfitMonth: json['total_profit_month'].toString(),
        totalProfitYear: json['total_profit_year'].toString(),
        totalProfitWeek: json['total_profit_week'].toString(),
      );
}
