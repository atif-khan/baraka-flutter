import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/portfolio.dart';
import '../bloc/portfolio_bloc.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static const String routeName = '/portfolio';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PortfolioBloc>()..add(const PortfolioRequested()),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          if (state.data == null) {
            return const Center(child: Text('No data'));
          }
          final data = state.data!;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _HeaderCard(
                  netValue: data.balance.netValue,
                  pnl: data.balance.pnl,
                  pnlPercent: data.balance.pnlPercentage,
                ),
              ),
              SliverList.builder(
                itemCount: data.positions.length,
                itemBuilder: (context, index) => _PositionTile(
                  position: data.positions[index],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final double netValue;
  final double pnl;
  final double pnlPercent;

  const _HeaderCard({
    required this.netValue,
    required this.pnl,
    required this.pnlPercent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pnlColor = pnl >= 0 ? Colors.green : Colors.red;

    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          AssetImage('assets/images/placeholder.png'),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'John Doe',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(netValue.toStringAsFixed(2),
                          style: theme.textTheme.headlineMedium),
                      Text('Net Value', style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${pnl.toStringAsFixed(2)} (${(pnlPercent).toStringAsFixed(0)}%)',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: pnlColor),
                      ),
                      Text('PnL (PnL %)', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _PositionTile extends StatelessWidget {
  final PositionEntity position;

  const _PositionTile({required this.position});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pnlColor = position.pnl >= 0 ? Colors.green : Colors.red;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(position.instrument.ticker,
                      style: theme.textTheme.titleLarge),
                  Text(
                    '${position.pnl.toStringAsFixed(2)} (${position.pnlPercentage.toStringAsFixed(0)}%)',
                    style:
                        theme.textTheme.titleMedium?.copyWith(color: pnlColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('${position.instrument.currency} '),
                      Text(
                          position.instrument.lastTradedPrice
                              .toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text(
                      '${position.quantity.toStringAsFixed(0)} x ${position.averagePrice.toStringAsFixed(2)}  =  ${position.cost.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(position.instrument.name,
                          style: theme.textTheme.bodySmall),
                      Text(position.instrument.exchange,
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Text(position.marketValue.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 4)
      ],
    );
  }
}
