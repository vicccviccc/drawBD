# Modelo relacional - Sistema de Gestão de Cemitério

Passei o modelo de entidades e relacionamentos para tabelas. As FKs ficam do lado muitos nas relações 1:N. Nas relações 1:1 usei UNIQUE junto da FK. No N:N entre cobranças e serviços usei a tabela ItemCobranca.

**PK:** chave primária. **FK:** chave estrangeira. **UK:** campo único. Os tipos e outras restrições estão no [script-ddl.sql](script-ddl.sql).

## Tabelas e campos

### Responsavel

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idResponsavel | INT | PK |
| nome | VARCHAR(150) | — |
| cpf | VARCHAR(14) | UK |
| telefone | VARCHAR(20) | — |
| endereco | VARCHAR(255) | — |

### Jazigo

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| id_jazigo | INT | PK |
| codigo_localizacao | VARCHAR(100) | UK |
| tipo_estrutura | VARCHAR(100) | — |
| capacidade_maxima | INT | — |
| status_ocupacao | VARCHAR(30) | — |
| Responsavel_idResponsavel | INT | FK → Responsavel.idResponsavel |

### Falecido

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idFalecido | INT | PK |
| nome | VARCHAR(150) | — |
| cpf | VARCHAR(14) | — |
| data_nascimento | DATE | — |
| data_falecimento | DATE | — |
| num_certidao_obito | VARCHAR(50) | UK |

### Sepultamento

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| id_sepultamento | INT | PK |
| data_sepultamento | DATE | — |
| horario | TIME | — |
| observacoes | VARCHAR(255) | — |
| Jazigo_id_jazigo | INT | FK → Jazigo.id_jazigo |
| Falecido_idFalecido | INT | FK → Falecido.idFalecido, UK |

### Exumacao

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idExumacao | INT | PK |
| data_exumacao | DATE | — |
| motivo | VARCHAR(255) | — |
| autorizacao_legal | VARCHAR(50) | UK |
| Sepultamento_id_sepultamento | INT | FK → Sepultamento.id_sepultamento, UK |

### Cobranca

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idCobranca | INT | PK |
| valor | DECIMAL(10,2) | — |
| data_emissao | DATE | — |
| data_vencimento | DATE | — |
| data_pagamento | DATE | — |
| status_pagamento | VARCHAR(30) | — |
| Responsavel_idResponsavel | INT | FK → Responsavel.idResponsavel |

### ResponsavelEmail

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idResponsavel | INT | PK, FK → Responsavel.idResponsavel |
| email | VARCHAR(100) | PK |
| tipo | VARCHAR(20) | — |
| data_cadastro | DATE | — |

### TipoServico

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idServico | INT | PK |
| codigo | VARCHAR(35) | UK |
| descricao | VARCHAR(120) | — |
| valor_referencia | DECIMAL(10,2) | — |

### ItemCobranca

| Campo | Tipo | Chave / referência |
| --- | --- | --- |
| idCobranca | INT | PK, FK → Cobranca.idCobranca |
| idServico | INT | PK, FK → TipoServico.idServico |
| quantidade | INT | — |
| precoPraticado | DECIMAL(10,2) | — |

## Relações

- Responsavel 1:N Jazigo, Cobranca e ResponsavelEmail.
- Jazigo 1:N Sepultamento.
- Falecido 1:0..1 Sepultamento; cada sepultamento possui um falecido.
- Sepultamento 1:0..1 Exumacao; cada exumação possui um sepultamento anterior.
- Cobranca N:N TipoServico através de ItemCobranca (duas FKs e PK composta).

ResponsavelEmail também possui chave composta, pelo ID do responsável e pelo email. A quantidade e o preço ficam em ItemCobranca porque dependem do serviço naquela cobrança.

O banco verifica as chaves e as restrições simples. A lotação do jazigo, o prazo legal de exumação e a soma dos itens de uma cobrança são conferências que precisam da lógica da operação. Os dados dos cenários respeitam essas regras.
