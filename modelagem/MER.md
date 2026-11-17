# Modelo do banco de dados - Sistema de Cemitério

Atualizei esta parte para deixar os relacionamentos de acordo com o script da atividade.

## 1. Tabelas do projeto

- **Responsavel:** nome, CPF e contato de quem cuida dos jazigos e recebe cobrancas.
- **Jazigo:** local, tipo de estrutura, capacidade e responsavel.
- **Falecido:** dados da pessoa e numero da certidao de obito.
- **Sepultamento:** data, horario e ligacao com o jazigo e o falecido.
- **Exumacao:** dados da exumacao e sepultamento ao qual ela pertence.
- **Cobranca:** valor, datas, situacao do pagamento e responsavel.
- **ResponsavelEmail:** separa os emails para um responsavel poder ter varios.
- **TipoServico:** lista os servicos que podem entrar em uma cobranca.
- **ItemCobranca:** junta cobrancas e servicos e guarda quantidade e preco.

## 2. Diagrama com os relacionamentos

O GitHub mostra este diagrama. As tabelas e os nomes das chaves seguem o arquivo de SQL novo.

```mermaid
erDiagram
    Responsavel ||--o{ Jazigo : possui
    Responsavel ||--o{ Cobranca : recebe
    Responsavel ||--o{ ResponsavelEmail : tem
    Jazigo ||--o{ Sepultamento : recebe
    Falecido ||--o| Sepultamento : possui
    Sepultamento ||--o| Exumacao : pode_gerar
    Cobranca ||--o{ ItemCobranca : tem
    TipoServico ||--o{ ItemCobranca : aparece_em

    Responsavel {
        int idResponsavel PK
        varchar nome
        varchar cpf
        varchar telefone
        varchar endereco
    }
    Jazigo {
        int id_jazigo PK
        varchar codigo_localizacao
        varchar tipo_estrutura
        int capacidade_maxima
        varchar status_ocupacao
        int Responsavel_idResponsavel FK
    }
    Falecido {
        int idFalecido PK
        varchar nome
        varchar cpf
        date data_nascimento
        date data_falecimento
        varchar num_certidao_obito
    }
    Sepultamento {
        int id_sepultamento PK
        date data_sepultamento
        time horario
        varchar observacoes
        int Jazigo_id_jazigo FK
        int Falecido_idFalecido FK
    }
    Exumacao {
        int idExumacao PK
        date data_exumacao
        varchar motivo
        varchar autorizacao_legal
        int Sepultamento_id_sepultamento FK
    }
    Cobranca {
        int idCobranca PK
        decimal valor
        date data_vencimento
        date data_pagamento
        varchar status_pagamento
        int Responsavel_idResponsavel FK
    }
    ResponsavelEmail {
        int idResponsavel PK,FK
        varchar email PK
    }
    TipoServico {
        int idServico PK
        varchar codigo
        varchar descricao
        decimal valor_referencia
    }
    ItemCobranca {
        int idCobranca PK,FK
        int idServico PK,FK
        int quantidade
        decimal precoPraticado
    }
```

## 3. Como ficaram os relacionamentos

| Relacao | Tipo | Como foi feita |
| --- | --- | --- |
| Responsavel - Jazigo | 1:N | FK do responsavel em Jazigo |
| Responsavel - Cobranca | 1:N | FK do responsavel em Cobranca |
| Responsavel - ResponsavelEmail | 1:N | FK do responsavel na tabela de emails |
| Jazigo - Sepultamento | 1:N | FK do jazigo em Sepultamento |
| Falecido - Sepultamento | 1:1 | FK unica do falecido em Sepultamento |
| Sepultamento - Exumacao | 1:1 (opcional) | FK unica do sepultamento em Exumacao |
| Cobranca - TipoServico | N:N | ItemCobranca, com duas FKs e chave composta |

## 4. Algumas observacoes

- Um mesmo servico pode aparecer em varias cobrancas, e uma cobranca pode ter varios servicos. Foi por isso que usamos a tabela **ItemCobranca**.
- No 1:1, usei **UNIQUE** nas FKs para nao permitir mais de um sepultamento por falecido nem mais de uma exumacao por sepultamento. Um falecido cadastrado ainda pode nao ter sepultamento, e um sepultamento pode nao ter exumacao.
- A certidao de obito foi colocada como obrigatoria em Falecido.
- O banco tem as chaves para garantir as ligacoes entre as tabelas. A verificacao de vagas no jazigo e do prazo de exumacao ainda depende da logica do sistema.

O arquivo `cemiterio.mwb` e a imagem `cemiterio.drawio.png` foram mantidos como registros da modelagem anterior. **Para esta atividade, o diagrama atualizado e o script novo sao a referencia.**
