/// Horizontal bar chart with bar label renderer example and hidden domain axis.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon_model.dart';

class StatsChart extends StatefulWidget {
  final _pokemon;
  StatsChart(this._pokemon, {Key key}) : super(key: key);

  _StatsChartState createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalBarLabelChart.withSampleData(widget._pokemon),
    );
  }
}

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarLabelChart.withSampleData(PokemonModel pokemon) {
    return new HorizontalBarLabelChart(
      _createPokemonData(pokemon),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.NoneRenderSpec(),
        showAxisLine: false,
      ),
    );
  }

  static List<charts.Series<PokemonStatus, String>> _createPokemonData(
      PokemonModel pokemon) {
    final data = pokemon.stats
        .map((stat) {
          return PokemonStatus(stat.stat["name"], stat.baseStat);
        })
        .toList()
        .reversed
        .toList();

    return [
      new charts.Series<PokemonStatus, String>(
          id: 'Status',
          domainFn: (PokemonStatus status, _) => status.name,
          measureFn: (PokemonStatus status, _) => status.value,
          colorFn: (PokemonStatus status, _) =>
              charts.Color.fromHex(code: "#e57373"),
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (PokemonStatus status, _) =>
              '${status.name.toUpperCase()}   •   ${status.value.toString()}')
    ];
  }
}

class PokemonStatus {
  final String name;
  final int value;

  PokemonStatus(this.name, this.value);
}
