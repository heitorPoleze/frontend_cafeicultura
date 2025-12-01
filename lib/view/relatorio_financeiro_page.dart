import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';

class RelatorioFinanceiroPage extends StatelessWidget {
  const RelatorioFinanceiroPage({super.key});

  static final List<Map<String, dynamic>> _mockData = [
    // Receitas
    {
      'dia': 5,
      'descricao': 'Venda de 50 sacas de café',
      'tipo': 'Receita',
      'valor': 10500.00,
    },
    {
      'dia': 25,
      'descricao': 'Venda de 20 sacas de café (Lote B)',
      'tipo': 'Receita',
      'valor': 4200.00,
    },

    // Despesas
    {
      'dia': 2,
      'descricao': 'Compra de fertilizante (N-P-K)',
      'tipo': 'Despesa',
      'valor': 3100.00,
    },
    {
      'dia': 10,
      'descricao': 'Pagamento de funcionários',
      'tipo': 'Despesa',
      'valor': 6800.00,
    },
    {
      'dia': 14,
      'descricao': 'Manutenção preventiva do trator',
      'tipo': 'Despesa',
      'valor': 1500.00,
    },
    {
      'dia': 28,
      'descricao': 'Conta de luz da fazenda',
      'tipo': 'Despesa',
      'valor': 450.00,
    },
  ];

  List<Map<String, dynamic>> get _sortedLancamentos {
    _mockData.sort((a, b) => a['dia'].compareTo(b['dia']));
    return _mockData;
  }

  double get _totalReceita => _mockData
      .where((i) => i['tipo'] == 'Receita')
      .fold(0.0, (sum, i) => sum + i['valor']);
  double get _totalDespesa => _mockData
      .where((i) => i['tipo'] == 'Despesa')
      .fold(0.0, (sum, i) => sum + i['valor']);
  double get _saldoMensal => _totalReceita - _totalDespesa;

  Widget buildFinanceRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color saldoColor = _saldoMensal >= 0
        ? Colors.green.shade700
        : Colors.red.shade700;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relatório Financeiro Detalhado',
          style: TextStyle(color: AppColors.appBranco),
        ),
        backgroundColor: AppColors.verdePrimaria,
        foregroundColor: AppColors.appBranco,
        elevation: 0,
      ),
      backgroundColor: AppColors.appBranco,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lançamentos de Novembro de 2025',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.marrom,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildRow(
                      'Receita Bruta:',
                      'R\$ ${_totalReceita.toStringAsFixed(2)}',
                      Colors.green.shade700,
                    ),
                    _buildRow(
                      'Total de Despesas:',
                      'R\$ ${_totalDespesa.toStringAsFixed(2)}',
                      Colors.red.shade700,
                    ),
                    const Divider(height: 25, thickness: 2),
                    _buildRow(
                      'SALDO LÍQUIDO:',
                      'R\$ ${_saldoMensal.toStringAsFixed(2)}',
                      saldoColor,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Detalhamento das Transações:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.verdePrimaria,
              ),
            ),
            const Divider(height: 20),

            ..._sortedLancamentos.map((transacao) {
              final isReceita = transacao['tipo'] == 'Receita';
              final color = isReceita
                  ? Colors.green.shade600
                  : Colors.red.shade600;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: AppCard(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${transacao['dia']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            Text(
                              isReceita ? 'REC' : 'DESP',
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transacao['descricao'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Novembro 2025',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        'R\$ ${transacao['valor'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
