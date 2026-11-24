# hotel-nebula
Projeto de banco de dados Hotel Nebula

# Hotel Nebula

## Sobre o projeto

O Hotel Nebula é um projeto de banco de dados desenvolvido para organizar as informações de uma rede hoteleira, facilitando o gerenciamento de hóspedes, quartos, reservas, hospedagens, pagamentos, serviços e avaliações.

O objetivo é estruturar os dados de forma organizada, utilizando modelagem de banco de dados e comandos SQL.

## Tecnologias utilizadas

- MySQL
- MySQL Workbench
- Draw.io

## Estrutura do projeto

### Modelagem

A pasta `0_Modelagem` contém os diagramas desenvolvidos durante o projeto:

- DER — Diagrama Entidade-Relacionamento.
- MER — Modelo Entidade-Relacionamento.
- MF — Modelo Físico do banco de dados.
- Arquivo `.mwb` do MySQL Workbench.

### Scripts SQL

A pasta `scripts` contém os arquivos utilizados na implementação do banco:

- `01_criacao_tabelas.sql` — criação do banco e das tabelas.
- `02_insercao_dados.sql` — inserção dos dados.
- `03_consultas.sql` — consultas para análise das informações.

## Estrutura do banco de dados

O banco de dados `hotel_nebula` possui 9 tabelas:

1. `hospedes`
2. `quartos`
3. `funcionarios`
4. `servicos`
5. `reservas`
6. `hospedagens`
7. `pagamentos`
8. `feedbacks`
9. `hospedagem_servicos`

As tabelas possuem relacionamentos, chaves primárias (PK) e chaves estrangeiras (FK), garantindo a organização e a integridade dos dados.

## Consultas SQL

Foram desenvolvidas e testadas consultas para:

- Identificar quartos disponíveis em determinado período.
- Listar hóspedes com maior número de reservas.
- Consultar a receita mensal.
- Identificar os serviços extras mais utilizados.
- Verificar os quartos com melhores avaliações.
- Consultar reservas canceladas.
- Identificar as hospedagens registradas por funcionário.

## Objetivo final

Organizar os dados de uma rede hoteleira por meio de um banco de dados relacional, aplicando conceitos de modelagem, relacionamentos, integridade referencial e consultas SQL.
