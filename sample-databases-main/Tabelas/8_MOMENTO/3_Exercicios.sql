USE momento;

-- =====================================================
-- NÍVEL 1: CONHECENDO A EMPRESA
-- =====================================================

-- 1.1 Cadastro de novo funcionário
-- Executado anteriormente. Não executar novamente.

-- INSERT INTO funcionarios (
--     primeiro_nome, sobrenome, email, senha, telefone,
--     data_contratacao, cargo_id, salario, gerente_id, departamento_id
-- )
-- VALUES (
--     'Nathaly', 'Costa', 'nathaly@gmail.com',
--     'senha_teste_nao_reutilizar', '11 40028922',
--     '2026-11-24', 9, 29000.00, NULL, 6
-- );
-- 1.2 Quantidade total de funcionários
SELECT COUNT(*) AS total_funcionarios
FROM funcionarios;

-- 1.3 Funcionários do Departamento de Tecnologia
SELECT COUNT(*) AS funcionarios_tecnologia
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Tecnologia';

-- 1.4 Lista de departamentos
SELECT departamento_nome
FROM departamentos;

-- 1.5 Quantidade de escritórios e países
SELECT
    COUNT(DISTINCT e.escritorio_id) AS total_escritorios,
    COUNT(DISTINCT p.pais_id) AS total_paises,
    GROUP_CONCAT(DISTINCT p.pais_nome) AS paises
FROM escritorios e
INNER JOIN paises p
    ON e.pais_id = p.pais_id;


-- =====================================================
-- NÍVEL 2: ANÁLISE FINANCEIRA BÁSICA
-- =====================================================

-- 2.1 Quantidade de funcionários em Vendas
SELECT COUNT(*) AS total_funcionarios_vendas
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Vendas';

-- 2.2 Custo total com salários de Vendas
SELECT SUM(f.salario) AS custo_total_salarios_vendas
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Vendas';

-- 2.3 Média salarial, excluindo CEO, CMO e CFO
SELECT AVG(f.salario) AS media_salarial
FROM funcionarios f
INNER JOIN cargos c
    ON f.cargo_id = c.cargo_id
WHERE c.cargo_nome NOT IN ('CEO', 'CMO', 'CFO');

-- 2.4 Média salarial de Tecnologia
SELECT AVG(f.salario) AS media_salarial_tecnologia
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Tecnologia';
-- 2.5 Departamento com maior média salarial
SELECT
    d.departamento_nome,
    AVG(f.salario) AS media_salarial
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
GROUP BY d.departamento_id, d.departamento_nome
ORDER BY media_salarial DESC
LIMIT 1;

-- 2.6 Departamento com menor número de funcionários
SELECT
    d.departamento_nome,
    COUNT(f.funcionario_id) AS total_funcionarios
FROM departamentos d
LEFT JOIN funcionarios f
    ON d.departamento_id = f.departamento_id
GROUP BY d.departamento_id, d.departamento_nome
HAVING COUNT(f.funcionario_id) = (
    SELECT MIN(total)
    FROM (
        SELECT COUNT(f2.funcionario_id) AS total
        FROM departamentos d2
        LEFT JOIN funcionarios f2
            ON d2.departamento_id = f2.departamento_id
        GROUP BY d2.departamento_id
    ) AS contagem
);

SELECT
    relacionamento,
    COUNT(*) AS total
FROM dependentes
GROUP BY relacionamento
ORDER BY total DESC;

-- 3.3 Funcionário contratado há mais tempo
SELECT
    primeiro_nome,
    sobrenome,
    data_contratacao
FROM funcionarios
ORDER BY data_contratacao ASC
LIMIT 1;

-- 3.4 Funcionário contratado mais recentemente
SELECT
    primeiro_nome,
    sobrenome,
    data_contratacao
FROM funcionarios
ORDER BY data_contratacao DESC
LIMIT 1;

-- 3.5 Cinco funcionários com maior tempo de empresa
SELECT
    primeiro_nome,
    sobrenome,
    data_contratacao
FROM funcionarios
ORDER BY data_contratacao ASC
LIMIT 5;

-- 3.6 Funcionários contratados na década de 1990
SELECT
    primeiro_nome,
    sobrenome,
    data_contratacao
FROM funcionarios
WHERE data_contratacao >= '1990-01-01'
  AND data_contratacao < '2000-01-01'
ORDER BY data_contratacao;

-- 3.7 Média salarial por ano de contratação
SELECT
    YEAR(data_contratacao) AS ano_contratacao,
    AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY YEAR(data_contratacao)
ORDER BY ano_contratacao;


-- =====================================================
-- NÍVEL 4: ANÁLISE DE SUPRIMENTOS
-- =====================================================

-- 4.1 Custo total de suprimentos por escritório
SELECT
    e.escritorio_id,
    e.escritorio_nome,
    SUM(s.quantidade_comprada * s.custo) AS custo_total
FROM suprimentos s
INNER JOIN escritorios e
    ON s.escritorio_id = e.escritorio_id
GROUP BY e.escritorio_id, e.escritorio_nome
ORDER BY custo_total DESC;

-- 4.2 Escritório com maior variedade de suprimentos
SELECT
    e.escritorio_nome,
    COUNT(DISTINCT s.suprimento_nome) AS tipos_suprimentos
FROM escritorios e
INNER JOIN suprimentos s
    ON e.escritorio_id = s.escritorio_id
GROUP BY e.escritorio_id, e.escritorio_nome
ORDER BY tipos_suprimentos DESC
LIMIT 1;

-- 4.3 Suprimento com maior custo unitário
SELECT
    suprimento_nome,
    custo
FROM suprimentos
ORDER BY custo DESC
LIMIT 1;

-- 4.4 Valor total do estoque de suprimentos
SELECT
    SUM(quantidade_comprada * custo) AS valor_total_estoque
FROM suprimentos;
    f.sobrenome,
    COUNT(d.dependente_id) AS total_dependentes
FROM funcionarios f
LEFT JOIN dependentes d
    ON f.funcionario_id = d.funcionario_id
WHERE f.data_contratacao < '1990-01-01'
GROUP BY f.funcionario_id, f.primeiro_nome, f.sobrenome;

-- Conferir vendas dos funcionários antigos
SELECT
    f.funcionario_id,
    f.primeiro_nome,
    f.sobrenome,
    COUNT(v.venda_id) AS total_vendas
FROM funcionarios f
LEFT JOIN vendas v
    ON f.funcionario_id = v.funcionario_id
WHERE f.data_contratacao < '1990-01-01'
GROUP BY f.funcionario_id, f.primeiro_nome, f.sobrenome;

-- Adaptação realizada: preservar os registros
-- e marcar os funcionários antigos como aposentados.
-- A coluna e a atualização já foram executadas anteriormente.

-- ALTER TABLE funcionarios
-- ADD COLUMN status_funcionario VARCHAR(20)
-- DEFAULT 'Ativo';

-- UPDATE funcionarios
-- SET status_funcionario = 'Aposentado'
-- WHERE funcionario_id IN (100, 101, 200);

-- Conferir funcionários aposentados
SELECT
    funcionario_id,
    primeiro_nome,
    sobrenome,
    status_funcionario
FROM funcionarios
WHERE status_funcionario = 'Aposentado';


-- =====================================================
-- CONFERÊNCIAS FINAIS
-- =====================================================

-- Conferir funcionários de Tecnologia
SELECT
    funcionario_id,
    primeiro_nome,
    sobrenome,
    salario,
    departamento_id,
    cargo_id
FROM funcionarios
WHERE departamento_id = 6;

-- Conferir cargo de Bruce Ernst
SELECT
    f.funcionario_id,
    f.primeiro_nome,
    f.sobrenome,
    c.cargo_nome,
    f.salario
FROM funcionarios f
INNER JOIN cargos c
    ON f.cargo_id = c.cargo_id
WHERE f.funcionario_id = 104;

-- Conferir cargo Senior Web Developer
SELECT *
FROM cargos
WHERE cargo_nome = 'Senior Web Developer';

-- Conferir Headsets
SELECT *
FROM suprimentos
WHERE suprimento_nome = 'Headsets'
  AND escritorio_id = 1400;

-- Conferir estrutura das tabelas
DESCRIBE funcionarios;
DESCRIBE departamentos;
DESCRIBE cargos;
DESCRIBE dependentes;
DESCRIBE suprimentos;
DESCRIBE produtos;
DESCRIBE vendas;

-- Conferir tabelas existentes
SHOW TABLES;


USE momento;

-- =====================================================
-- NÍVEL 7: ANÁLISE AVANÇADA COM AGREGAÇÕES
-- =====================================================

              f2.status_funcionario IS NULL
              OR f2.status_funcionario <> 'Aposentado'
          )
      )
ORDER BY d.departamento_nome, f.salario DESC;


-- 7.4 Quantidade de contratações por ano
SELECT
    YEAR(data_contratacao) AS ano_contratacao,
    COUNT(*) AS total_contratacoes
FROM funcionarios
GROUP BY YEAR(data_contratacao)
ORDER BY ano_contratacao;


-- 7.5 Ranking de funcionários por desempenho em vendas
-- considerando quantidade de transações e receita total
SELECT
    f.funcionario_id,
    f.primeiro_nome,
    f.sobrenome,
    COUNT(v.venda_id) AS total_vendas,
    SUM(
        v.quantidade_vendida *
        CAST(REPLACE(p.produto_price, ',', '.') AS DECIMAL(10,2))
    ) AS receita_total
FROM funcionarios f
INNER JOIN vendas v
    ON f.funcionario_id = v.funcionario_id
INNER JOIN produtos p
    ON v.produto_id = p.produto_id
WHERE f.status_funcionario IS NULL
   OR f.status_funcionario <> 'Aposentado'
GROUP BY
    f.funcionario_id,
    f.primeiro_nome,
    f.sobrenome
ORDER BY receita_total DESC;


-- 7.6 Produtos vendidos por apenas um funcionário
SELECT
    p.produto_id,
    p.produto_nome,
    COUNT(DISTINCT v.funcionario_id) AS total_vendedores,
    MAX(f.primeiro_nome) AS primeiro_nome_vendedor,
    MAX(f.sobrenome) AS sobrenome_vendedor
FROM produtos p
INNER JOIN vendas v
    ON p.produto_id = v.produto_id
INNER JOIN funcionarios f
    ON v.funcionario_id = f.funcionario_id
WHERE f.status_funcionario IS NULL
   OR f.status_funcionario <> 'Aposentado'
GROUP BY p.produto_id, p.produto_nome
HAVING COUNT(DISTINCT v.funcionario_id) = 1
ORDER BY p.produto_nome;


USE momento;

        COUNT(d.departamento_id) AS total_departamentos
    FROM escritorios e
    LEFT JOIN departamentos d
        ON e.escritorio_id = d.escritorio_id
    GROUP BY e.pais_id
) dep
    ON p.pais_id = dep.pais_id

LEFT JOIN (
    SELECT
        e.pais_id,
        COUNT(f.funcionario_id) AS total_funcionarios,
        SUM(f.salario) AS folha_salarial
    FROM escritorios e
    INNER JOIN departamentos d
        ON e.escritorio_id = d.escritorio_id
    INNER JOIN funcionarios f
        ON d.departamento_id = f.departamento_id
    WHERE f.status_funcionario IS NULL
       OR f.status_funcionario <> 'Aposentado'
    GROUP BY e.pais_id
) func
    ON p.pais_id = func.pais_id

LEFT JOIN (
    SELECT
        e.pais_id,
        SUM(s.quantidade_comprada * s.custo) AS custo_suprimentos
    FROM escritorios e
    INNER JOIN suprimentos s
        ON e.escritorio_id = s.escritorio_id
    GROUP BY e.pais_id
) sup
    ON p.pais_id = sup.pais_id

ORDER BY p.pais_nome;


-- 10.1 VERIFICAÇÃO PRÉVIA
SELECT *
FROM regioes
ORDER BY regiao_id;

SELECT *
FROM paises
ORDER BY pais_id;

SELECT *
FROM escritorios
ORDER BY escritorio_id;


-- Verificar se já existe um escritório em São Paulo
SELECT
    e.escritorio_id,
    e.escritorio_nome,
    p.pais_nome
FROM escritorios e
INNER JOIN paises p
    ON e.pais_id = p.pais_id
WHERE e.escritorio_nome = 'Momento Brasil';


-- 10.2 Verificar se o departamento já existe
SELECT *
FROM departamentos
WHERE departamento_nome = 'Operações LATAM';


-- =====================================================
-- 10.4 TRÊS ESCRITÓRIOS COM MAIORES CUSTOS
-- =====================================================

SELECT
    e.escritorio_id,
    e.escritorio_nome,
    SUM(s.quantidade_comprada * s.custo) AS custo_total
FROM escritorios e
INNER JOIN suprimentos s
    ON e.escritorio_id = s.escritorio_id
GROUP BY e.escritorio_id, e.escritorio_nome
ORDER BY custo_total DESC
LIMIT 3;

    venda_data,
    funcionario_id
FROM vendas
WHERE funcionario_id IS NULL;


-- =====================================================
-- 10.8 VENDAS COM FUNCIONÁRIO INEXISTENTE
-- =====================================================

SELECT
    v.venda_id,
    v.funcionario_id,
    v.produto_id,
    v.venda_data
FROM vendas v
LEFT JOIN funcionarios f
    ON v.funcionario_id = f.funcionario_id
WHERE v.funcionario_id IS NOT NULL
  AND f.funcionario_id IS NULL;


-- =====================================================
-- 10.9 VERIFICAR VARIAÇÃO DE PREÇOS POR PRODUTO
-- =====================================================

-- LIMITAÇÃO DO MODELO:
-- O preço está armazenado em produtos.produto_price.
-- A tabela vendas não possui uma coluna de preço unitário
-- registrado no momento de cada transação.
--
-- Assim, não é possível comparar preços históricos
-- de um mesmo produto entre diferentes vendas.
--
-- Esta consulta mostra os preços cadastrados dos produtos
-- que aparecem nas vendas.

SELECT
    p.produto_id,
    p.produto_nome,
    CAST(
        REPLACE(p.produto_price, ',', '.')
        AS DECIMAL(10,2)
    ) AS preco_unitario_cadastrado,
    COUNT(v.venda_id) AS total_vendas
FROM produtos p
INNER JOIN vendas v
    ON p.produto_id = v.produto_id
GROUP BY
    p.produto_id,
    p.produto_nome,
    p.produto_price
ORDER BY p.produto_nome;


-- =====================================================
-- 10.10 DASHBOARD EXECUTIVO
-- Uma única consulta com subconsultas de agregação
-- =====================================================

SELECT
    (
        SELECT COUNT(*)
        FROM funcionarios
        WHERE status_funcionario IS NULL
           OR status_funcionario <> 'Aposentado'
    ) AS total_funcionarios,

    (
        SELECT COALESCE(SUM(salario), 0)
        FROM funcionarios
        WHERE status_funcionario IS NULL
           OR status_funcionario <> 'Aposentado'
    ) AS custo_total_salarios,

    (
        SELECT COUNT(*)
        FROM departamentos
    ) AS total_departamentos,

    (
        SELECT COUNT(*)
        FROM escritorios
    ) AS total_escritorios,

    (
        SELECT COALESCE(
            SUM(
                v.quantidade_vendida *
                CAST(
                    REPLACE(p.produto_price, ',', '.')
                    AS DECIMAL(10,2)
                )
            ),
            0
        )
        FROM vendas v
        INNER JOIN produtos p
            ON v.produto_id = p.produto_id
    ) AS receita_total_vendas,

    (
        SELECT p.produto_nome
        FROM produtos p
        INNER JOIN vendas v
            ON p.produto_id = v.produto_id
        GROUP BY p.produto_id, p.produto_nome
        ORDER BY SUM(v.quantidade_vendida) DESC
        LIMIT 1
    ) AS produto_mais_vendido;

-- 10.3 VERIFICAR FUNCIONÁRIOS VINCULADOS AO NOVO DEPARTAMENTO
SELECT
    f.funcionario_id,
    f.primeiro_nome,
    f.sobrenome,
    f.email,
    f.departamento_id,
    d.departamento_nome
FROM funcionarios f
LEFT JOIN departamentos d
    ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Operações LATAM'
ORDER BY f.funcionario_id;

