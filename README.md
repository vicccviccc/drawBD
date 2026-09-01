# Sistema de Gestão de Cemitério

Repositório criado para a disciplina de Banco de Dados. O projeto consiste no mapeamento e modelagem conceitual do banco de dados para um sistema de administração de cemitério.

## Mini-Mundo

O sistema tem como objetivo controlar o espaço físico do cemitério, os registros de sepultamentos e o cadastro dos responsáveis por cada jazigo.

O cemitério é organizado em setores e quadras, onde ficam localizados os jazigos. Cada jazigo possui um código de identificação, o tipo de estrutura (gaveta, ossuário, jazigo da família) e uma capacidade máxima de pessoas.

Para utilizar um jazigo, é necessário cadastrar um responsável (titular), com nome, CPF e dados de contato. Esse responsável fica vinculado ao contrato e responde pelo pagamento das taxas anuais de manutenção.

Quando ocorre um óbito, os dados do falecido (nome, CPF, data do óbito e número da certidão) são cadastrados para registrar o sepultamento em um jazigo com espaço disponível. O sistema também mantém o histórico de exumações e controla o vencimento das taxas de manutenção cobradas dos responsáveis.

## Regras de Negócio

* Um responsável pode ter uma ou mais concessões de jazigos.
* Um jazigo só pode receber um novo sepultamento se não tiver atingido a capacidade máxima de gavetas ocupadas.
* O registro de sepultamento exige obrigatoriamente a inclusão do número da certidão de óbito.
* A exumação só pode ser agendada após o término do prazo legal mínimo contado a partir da data do sepultamento.
