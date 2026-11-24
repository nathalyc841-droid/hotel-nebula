# Hotel Nebula — Modelo Lógico

> Este modelo apresenta as tabelas, colunas, tipos de dados, restrições e relacionamentos do sistema Hotel Nebula.

---

## Tabelas

### hospedes

| Coluna          | Tipo          | Restrições         |
|-----------------|---------------|--------------------|
| id_hospede      | INT           | PK, AUTO_INCREMENT |
| nome            | VARCHAR(100)  | NOT NULL           |
| email           | VARCHAR(100)  | UNIQUE, NOT NULL   |
| cpf             | VARCHAR(14)   | UNIQUE             |
| telefone        | VARCHAR(20)   |                    |
| data_nascimento | DATE          |                    |
| endereco        | VARCHAR(200)  |                    |

---

### quartos

| Coluna       | Tipo          | Restrições                          |
|--------------|---------------|-------------------------------------|
| id_quarto    | INT           | PK, AUTO_INCREMENT                  |
| numero       | VARCHAR(10)   | UNIQUE, NOT NULL                    |
| tipo         | VARCHAR(50)   | NOT NULL                            |
| capacidade   | INT           | CHECK (capacidade > 0)              |
| preco_diaria | DECIMAL(10,2) | NOT NULL, CHECK (preco_diaria > 0) |
| status       | VARCHAR(20)   |                                     |
| descricao    | TEXT          |                                     |

---

### reservas

| Coluna        | Tipo     | Restrições                                      |
|---------------|----------|-------------------------------------------------|
| id_reserva    | INT      | PK, AUTO_INCREMENT                              |
| id_hospede    | INT      | FK → hospedes                                   |
| id_quarto     | INT      | FK → quartos                                    |
| data_checkin  | DATE     | NOT NULL                                        |
| data_checkout | DATE     | NOT NULL, CHECK (data_checkout > data_checkin) |
| status        | VARCHAR(20) |                                               |
| data_reserva  | DATETIME | NOT NULL                                        |

---

### hospedagens

| Coluna         | Tipo     | Restrições            |
|----------------|----------|-----------------------|
| id_hospedagem  | INT      | PK, AUTO_INCREMENT    |
| id_reserva     | INT      | UNIQUE, FK → reservas |
| id_funcionario | INT      | FK → funcionarios     |
| checkin_real   | DATETIME |                       |
| checkout_real  | DATETIME |                       |
| observacoes    | TEXT     |                       |

---

### pagamentos

| Coluna           | Tipo          | Restrições                   |
|------------------|---------------|------------------------------|
| id_pagamento     | INT           | PK, AUTO_INCREMENT           |
| id_hospedagem    | INT           | FK → hospedagens             |
| valor            | DECIMAL(10,2) | NOT NULL, CHECK (valor > 0)  |
| metodo           | VARCHAR(30)   |                              |
| data_pagamento   | DATETIME      | NOT NULL                     |
| status_pagamento | VARCHAR(20)   | NOT NULL                     |

---

### funcionarios

| Coluna         | Tipo         | Restrições         |
|----------------|--------------|--------------------|
| id_funcionario | INT          | PK, AUTO_INCREMENT |
| nome           | VARCHAR(100) | NOT NULL           |
| cargo          | VARCHAR(50)  |                    |
| email          | VARCHAR(100) | UNIQUE             |
| telefone       | VARCHAR(20)  |                    |

---

### servicos

| Coluna     | Tipo          | Restrições                   |
|------------|---------------|------------------------------|
| id_servico | INT           | PK, AUTO_INCREMENT           |
| nome       | VARCHAR(100)  | NOT NULL                     |
| descricao  | TEXT          |                              |
| preco      | DECIMAL(10,2) | NOT NULL, CHECK (preco > 0)  |

---

### feedbacks

| Coluna        | Tipo     | Restrições                              |
|---------------|----------|-----------------------------------------|
| id_feedback   | INT      | PK, AUTO_INCREMENT                      |
| id_hospedagem | INT      | FK → hospedagens                        |
| nota          | INT      | NOT NULL, CHECK (nota BETWEEN 1 AND 5) |
| comentario    | TEXT     |                                         |
| data_feedback | DATETIME | NOT NULL                                |

---

### hospedagem_servicos

| Coluna         | Tipo          | Restrições                                  |
|----------------|---------------|---------------------------------------------|
| id_hospedagem  | INT           | PK, FK → hospedagens                        |
| id_servico     | INT           | PK, FK → servicos                           |
| quantidade     | INT           | NOT NULL, DEFAULT 1, CHECK (quantidade > 0) |
| valor_unitario | DECIMAL(10,2) | NOT NULL                                    |

---

## Relacionamentos identificados

```text
hospedes ||--o{ reservas : "faz"
quartos ||--o{ reservas : "recebe"
reservas ||--o| hospedagens : "gera"
hospedagens ||--o{ pagamentos : "gera"
funcionarios ||--o{ hospedagens : "atende"
hospedagens ||--o{ hospedagem_servicos : "inclui"
servicos ||--o{ hospedagem_servicos : "compõe"
hospedagens ||--o{ feedbacks : "recebe"
```

## Regras de negócio

- Cada hóspede pode realizar várias reservas.
- Cada reserva está vinculada a um hóspede e a um quarto.
- Uma reserva pode gerar uma hospedagem.
- Cada hospedagem está associada a um funcionário responsável.
- Uma hospedagem pode possuir um ou mais pagamentos.
- Uma hospedagem pode incluir diferentes serviços, registrados na tabela hospedagem_servicos.
- Cada hospedagem pode receber avaliações dos hóspedes por meio da tabela feedbacks.
- Os quartos possuem capacidade e preço de diária definidos.
- As datas de checkout devem ser posteriores às datas de check-in.
- As avaliações devem possuir notas entre 1 e 5.