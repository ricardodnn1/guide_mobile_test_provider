import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:guidemobileprov/app/trading/controller/trading_controller.dart';
import 'package:guidemobileprov/app/trading/model/trading_sessions_model.dart';
import 'package:intl/intl.dart';

class TradingChartView extends StatefulWidget {
  const TradingChartView({super.key});

  @override
  State<TradingChartView> createState() => _TradingChartViewState();
}

class _TradingChartViewState extends State<TradingChartView> {
  final controller = HomeController();

  List<Color> colors = const [
    Color(0xFF3F51B5),
  ];

  List<FlSpot> dataChart = [];
  List dataComplete = [];
  List<TradingSessionsModel> list = [];
  double maxX = 0;
  double maxY = 0;
  double minY = 0;

  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };
  late NumberFormat real;
  ValueNotifier<bool> loaded = ValueNotifier(false);

  setDados() async {
    loaded.value = false;
    if (controller.tradingSessionsList.isEmpty) {
      await controller.getTradingSessionsList();
    }

    list = controller.tradingSessionsList;
    dataChart = [];

    if (list.isNotEmpty) {
      dataComplete = list.reversed.map((e) {
        double quote = e.quotationValue ?? 0;
        return [
          quote,
          DateTime.fromMillisecondsSinceEpoch(int.parse(e.dataTrading!) * 1000)
        ];
      }).toList();

      maxX = dataComplete.length.toDouble();
      maxY = 0;
      minY = double.infinity;

      for (var item in dataComplete) {
        maxY = item[0] > maxY ? item[0] : maxY;
        minY = item[0] < minY ? item[0] : minY;
      }

      for (int i = 0; i < dataComplete.length; i++) {
        dataChart.add(FlSpot(
          i.toDouble(),
          dataComplete[i][0],
        ));
      }
    }

    if (dataComplete.isNotEmpty) {
      loaded.value = true;
    }
  }

  LineChartData getChartData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: dataChart,
          isCurved: true,
          colors: colors,
          barWidth: 1,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            colors: colors.map((color) => color.withOpacity(0.15)).toList(),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Color(0xFF343434),
          getTooltipItems: (data) {
            return data.map((item) {
              final date = getDate(item.spotIndex);
              return LineTooltipItem(
                real.format(item.y),
                const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '\n $date',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(.5),
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }

  getDate(int index) {
    DateTime date = dataComplete[index][1];
    return DateFormat('dd/MM/y').format(date);
  }

  @override
  void initState() {
    controller.cleanList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    real =
        NumberFormat.currency(locale: locale['locale'], name: locale['name']);
    setDados();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Resultado da variação'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: size.height / 1.5,
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: ValueListenableBuilder(
                      valueListenable: loaded,
                      builder: (context, bool isLoaded, _) {
                        return (isLoaded)
                            ? LineChart(
                                getChartData(),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
