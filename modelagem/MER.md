# Modelo Entidade-Relacionamento (MER) - Sistema de Cemitério

## 1. Entidades

* **Responsavel:** Pessoa responsável pelo contrato do jazigo e pelo pagamento das taxas.
* **Jazigo:** Espaço físico (gaveta, ossuário, sepultura) destinado aos sepultamentos.
* **Falecido:** Registro do indivíduo falecido que será ou foi sepultado.
* **Sepultamento:** Registro da cerimônia/procedimento de sepultamento de um falecido em um jazigo.
* **Exumacao:** Registro da retirada dos restos mortais do jazigo após o prazo legal.
* **Cobranca:** Registro de taxas de manutenção anual e serviços emitidos para o responsável.

## 2. Atributos

* **Responsavel:**
  * `id_responsavel` (PK)
  * `nome`
  * `cpf`
  * `telefone`
  * `endereco`

* **Jazigo:**
  * `id_jazigo` (PK)
  * `codigo_localizacao` (ex: Quadra A, Setor 2, Nº 15)
  * `tipo` (Gaveta, Ossuário, Jazigo da Família)
  * `capacidade_maxima`
  * `status` (Disponível, Ocupado, Manutenção)

* **Falecido:**
  * `id_falecido` (PK)
  * `nome`
  * `cpf`
  * `data_nascimento`
  * `data_falecimento`
  * `num_certidao_obito`

* **Sepultamento:**
  * `id_sepultamento` (PK)
  * `data_sepultamento`
  * `horario`
  * `observacoes`

* **Exumacao:**
  * `id_exumacao` (PK)
  * `data_exumacao`
  * `motivo`
  * `autorizacao_legal`

* **Cobranca:**
  * `id_cobranca` (PK)
  * `valor`
  * `data_vencimento`
  * `data_pagamento`
  * `status_pagamento` (Pendente, Pago, Atrasado)

## 3. Relacionamentos e Cardinalidades

* **Responsavel - Possui - Jazigo (1:N)**
  * Um responsável pode ter um ou mais jazigos sob sua responsabilidade (1,N).
  * Cada jazigo pertence a apenas um responsável titular (1,1).

* **Jazigo - Abriga - Sepultamento (1:N)**
  * Um jazigo pode receber vários sepultamentos ao longo do tempo (1,N).
  * Um sepultamento ocorre em apenas um jazigo (1,1).

* **Falecido - Possui - Sepultamento (1:1)**
  * Um falecido possui apenas um registro de sepultamento (1,1).
  * Um sepultamento refere-se a apenas um falecido (1,1).

* **Sepultamento - Gerar - Exumacao (1:1)**
  * Um sepultamento pode eventualmente gerar uma exumação (0,1).
  * Uma exumação obrigatoriamente pertence a um sepultamento prévio (1,1).

* **Responsavel - Recebe - Cobranca (1:N)**
  * Um responsável pode receber várias cobranças ao longo do tempo (1,N).
  * Cada cobrança é emitida para apenas um responsável (1,1).
