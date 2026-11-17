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

## Atividade de relacionamentos em SQL

Fiz uma versao do banco com as tabelas e chaves organizadas para a atividade de relacionamentos 1:N e N:N.

Arquivos usados nesta atividade:

- [atividade_relacionamentos.sql](modelagem/atividade_relacionamentos.sql): cria o banco todo, com as 9 tabelas e suas chaves.
- [MER.md](modelagem/MER.md): diagrama atualizado e explicacao das relacoes.
- [testar_relacionamentos.sql](modelagem/testar_relacionamentos.sql): alguns INSERTs e SELECTs para conferir as ligacoes.

### Como eu testo no MySQL Workbench

1. Abrir o Workbench e conectar no servidor MySQL.
2. Abrir o arquivo `modelagem/atividade_relacionamentos.sql`.
3. Executar o script completo pelo botao do raio e conferir o painel **Output**.
4. Abrir `modelagem/testar_relacionamentos.sql` e executar para ver as FKs e um teste de 1:N e N:N.
5. Conferir se aparecem as 9 tabelas e se o SELECT final mostra 3 itens de cobranca.

**Cuidado:** o script principal tem `DROP DATABASE IF EXISTS cemiterio`. Ele apaga os dados anteriores do banco `cemiterio` para criar tudo do zero. Nao execute se tiver informacoes que precisa guardar sem antes fazer backup.

Os arquivos `cemiterioscr.sql`, `distru.sql`, `normalizacao_.sql`, o `.mwb` e a imagem antiga foram mantidos porque fazem parte das etapas anteriores do projeto. Para esta atividade, use primeiro o arquivo `atividade_relacionamentos.sql`. O diagrama atualizado esta no `MER.md`.

Ainda preciso confirmar com o professor o prazo e a forma de entrega. A parte de verificar lotacao do jazigo e prazo legal de exumacao tambem nao fica resolvida so com as chaves estrangeiras.
