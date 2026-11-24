USE hotel_nebula;

-- 1. Quartos disponíveis em determinado período
SELECT q.id_quarto, q.numero, q.tipo
FROM quartos q
WHERE NOT EXISTS (
    SELECT 1
    FROM reservas r
    WHERE r.id_quarto = q.id_quarto
    AND r.status <> 'Cancelada'
    AND r.data_checkin < '2026-11-12'
    AND r.data_checkout > '2026-11-10'
);

-- 2. Hóspedes com mais reservas
SELECT h.nome, COUNT(r.id_reserva) AS total_reservas
FROM hospedes h
INNER JOIN reservas r ON h.id_hospede = r.id_hospede
GROUP BY h.id_hospede, h.nome
ORDER BY total_reservas DESC;

-- 3. Faturamento por mês
SELECT
    DATE_FORMAT(data_pagamento, '%Y-%m') AS mes,
    SUM(valor) AS faturamento
FROM pagamentos
WHERE status_pagamento = 'Pago'
GROUP BY DATE_FORMAT(data_pagamento, '%Y-%m')
ORDER BY mes;

-- 4. Serviços extras mais consumidos
SELECT
    s.nome,
    SUM(hs.quantidade) AS total_consumido
FROM servicos s
INNER JOIN hospedagem_servicos hs
    ON s.id_servico = hs.id_servico
GROUP BY s.id_servico, s.nome
ORDER BY total_consumido DESC;

-- 5. Quartos com melhores avaliações
SELECT
    q.numero,
    AVG(f.nota) AS media_avaliacao
FROM quartos q
INNER JOIN reservas r ON q.id_quarto = r.id_quarto
INNER JOIN hospedagens h ON r.id_reserva = h.id_reserva
INNER JOIN feedbacks f ON h.id_hospedagem = f.id_hospedagem
GROUP BY q.id_quarto, q.numero
ORDER BY media_avaliacao DESC;

-- 6. Reservas canceladas
SELECT
    r.id_reserva,
    h.nome AS hospede,
    q.numero AS quarto,
    r.data_checkin,
    r.data_checkout,
    r.status
FROM reservas r
INNER JOIN hospedes h ON r.id_hospede = h.id_hospede
INNER JOIN quartos q ON r.id_quarto = q.id_quarto
WHERE r.status = 'Cancelada';

-- 7. Quantidade de hospedagens por funcionário
SELECT
    f.nome AS funcionario,
    COUNT(h.id_hospedagem) AS total_hospedagens
FROM funcionarios f
LEFT JOIN hospedagens h ON f.id_funcionario = h.id_funcionario
GROUP BY f.id_funcionario, f.nome
ORDER BY total_hospedagens DESC;