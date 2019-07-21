/// Horizontal bar chart with bar label renderer example and hidden domain axis.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon.dart';

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
  factory HorizontalBarLabelChart.withSampleData(Pokemon pokemon) {
    return new HorizontalBarLabelChart(
      _createPokemonData(pokemon),
      // Disable animations for image tests.
      animate: true,
    );
  }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit and the
  // area outside of the bar is larger than the bar, it will draw outside of the
  // bar. Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,

      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.NoneRenderSpec(),
        showAxisLine: false,
      ),
    );
  }

  // static List<charts.Series<Ordinalstatus, String>> _createSampleData() {
  //   final data = [
  //     new Ordinalstatus('2014', 5),
  //     new Ordinalstatus('2015', 25),
  //     new Ordinalstatus('2016', 100),
  //     new Ordinalstatus('2017', 75),
  //   ];

  //   return [
  //     new charts.Series<Ordinalstatus, String>(
  //         id: 'status',
  //         domainFn: (Ordinalstatus status, _) => status.year,
  //         measureFn: (Ordinalstatus status, _) => status.status,
  //         data: data,
  //         // Set a label accessor to control the text of the bar label.
  //         labelAccessorFn: (Ordinalstatus status, _) =>
  //             '${status.year}: \$${status.status.toString()}')
  //   ];
  // }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PokemonStatus, String>> _createPokemonData(
      Pokemon pokemon) {
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
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (PokemonStatus status, _) =>
              '${status.name}: ${status.value.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class PokemonStatus {
  final String name;
  final int value;

  PokemonStatus(this.name, this.value);
}
