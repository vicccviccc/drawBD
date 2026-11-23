# Sistema de Gestão de Cemitério

Repositório criado para a disciplina de Banco de Dados. O projeto consiste no modelagem e implementação do banco de dados para um sistema de administração de cemitério.

## Mini-Mundo

O sistema tem como objetivo controlar o espaço físico do cemitério, os registros de sepultamentos e o cadastro dos responsáveis por cada jazigo.

O cemitério é organizado em setores e quadras, onde ficam localizados os jazigos. Cada jazigo possui um código de identificação, o tipo de estrutura (gaveta, ossuário, jazigo da família) e uma capacidade máxima de pessoas.

Para utilizar um jazigo, é necessário cadastrar um responsável (titular), com nome, CPF e dados de contato. Esse responsável fica vinculado ao jazigo e responde pelo pagamento das taxas de manutenção e dos serviços. Ele pode cadastrar mais de um e-mail, indicando o tipo e a data de cadastro.

Quando ocorre um óbito, os dados do falecido (nome, CPF, data do óbito e número da certidão) são cadastrados para registrar o sepultamento em um jazigo com espaço disponível. O sistema também mantém o histórico de exumações e controla o vencimento das cobranças dos responsáveis.

A administração mantém um cadastro dos tipos de serviço (manutenção, limpeza, sepultamento, exumação e transferência). Uma cobrança pode incluir vários serviços, com suas quantidades e preços. O mesmo serviço pode aparecer em várias cobranças.

## Regras de Negócio

* Um responsável pode ter uma ou mais concessões de jazigos.
* Um jazigo só pode receber um novo sepultamento se não tiver atingido a capacidade máxima de gavetas ocupadas.
* O registro de sepultamento exige obrigatoriamente a inclusão do número da certidão de óbito.
* A exumação só pode ser agendada após o término do prazo legal mínimo contado a partir da data do sepultamento.

* Cada sepultamento está vinculado a um falecido e pode gerar no máximo uma exumação.
* Uma cobrança tem um responsável e pode ter vários serviços. A tabela ItemCobranca guarda a quantidade e o preço praticado.
* A ocupação e a liberação de vagas precisam acompanhar os sepultamentos e as exumações. O prazo legal e a conferência de vagas ainda dependem da lógica do sistema.

## Atividade de relacionamentos em SQL (etapa anterior)

Fiz uma versao do banco com as tabelas e chaves organizadas para a atividade de relacionamentos 1:N e N:N.

Arquivos usados nesta atividade:

- [atividade_relacionamentos.sql](modelagem/atividade_relacionamentos.sql): cria o banco todo, com as 9 tabelas e suas chaves.
- [MER.md](modelagem/MER.md): diagrama atualizado e explicacao das relacoes.
- [testar_relacionamentos.sql](modelagem/testar_relacionamentos.sql): alguns INSERTs e SELECTs para conferir as ligacoes.

## Implementação SQL - DDL e DML

Separei o script de criação do banco do script que insere os dados. Mantive as tabelas anteriores e acrescentei os campos que faltavam.

- [Modelo conceitual (MER)](modelagem/MER.md)
- [Modelo relacional](modelagem/modelo-relacional.md)
- [script-ddl.sql](modelagem/script-ddl.sql) - criação das nove tabelas, chaves e restrições.
- [script-dml.sql](modelagem/script-dml.sql) - cinco cenários que contam a história das operações do cemitério.
- [consultas.sql](modelagem/consultas.sql) - consultas para conferir os registros e os relacionamentos.

