# Resultados dos testes no MySQL Workbench

Testamos os arquivos DDL, DML e consultas no dia 23/11/2026, usando o banco cemiterio_atividade.

## DDL e DML

O DDL criou as nove tabelas. Na primeira execução apareceu um aviso porque o banco ainda não existia. O DML foi executado e o COMMIT confirmou o salvamento dos dados.

## Quantidade de registros

| Tabela | Registros |
| --- | ---: |
| Responsavel | 6 |
| Jazigo | 7 |
| Falecido | 7 |
| Sepultamento | 7 |
| Exumacao | 5 |
| Cobranca | 7 |
| ResponsavelEmail | 7 |
| TipoServico | 5 |
| ItemCobranca | 15 |
| Total | 66 |

Todas as tabelas ficaram com pelo menos cinco registros.

## Relacionamento N:N

A consulta retornou 15 itens de cobrança. Um exemplo é a cobrança 7, de André Batista:

| Serviço | Quantidade | Preço unitário (R$) | Subtotal (R$) |
| --- | ---: | ---: | ---: |
| Manutenção anual do jazigo | 1 | 120,00 | 120,00 |
| Limpeza do jazigo | 2 | 80,00 | 160,00 |
| Serviço de sepultamento | 1 | 250,00 | 250,00 |
| Total | | | 530,00 |

## Conferência das cobranças

| idCobranca | Valor (R$) | Soma dos itens (R$) | Diferença (R$) |
| --- | ---: | ---: | ---: |
| 1 | 380,00 | 380,00 | 0,00 |
| 2 | 400,00 | 400,00 | 0,00 |
| 3 | 300,00 | 300,00 | 0,00 |
| 4 | 380,00 | 380,00 | 0,00 |
| 5 | 480,00 | 480,00 | 0,00 |
| 6 | 370,00 | 370,00 | 0,00 |
| 7 | 530,00 | 530,00 | 0,00 |

## Situação dos pagamentos

| Status | Quantidade | Total (R$) |
| --- | ---: | ---: |
| Pago | 6 | 2.310,00 |
| Pendente | 1 | 530,00 |
| Total | 7 | 2.840,00 |

## Ocupação dos jazigos

| Jazigo | Capacidade | Status | Ocupados | Vagas |
| --- | ---: | --- | ---: | ---: |
| 01 | 2 | Disponível | 1 | 1 |
| 02 | 1 | Disponível | 0 | 1 |
| 03 | 1 | Disponível | 0 | 1 |
| 04 | 2 | Disponível | 0 | 2 |
| 05 | 1 | Disponível | 0 | 1 |
| 06 | 1 | Ocupado | 1 | 0 |
| 07 | 3 | Disponível | 0 | 3 |
| Total | 11 | | 2 | 9 |

Os resultados acima foram registrados a partir dos testes no Workbench. As oito abas de resultados foram geradas. Depois das consultas houve uma tentativa de EXPLAIN sobre USE, que não é um comando válido e não faz parte dos scripts.


