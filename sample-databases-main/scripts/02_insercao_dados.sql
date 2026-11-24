USE hotel_nebula;

-- Inserção de hóspedes
INSERT INTO hospedes (nome, email, cpf, telefone, data_nascimento, endereco)
VALUES
('Ana Silva', 'ana@email.com', '111.111.111-11', '11999990001', '1995-04-12', 'São Paulo'),
('Carlos Souza', 'carlos@email.com', '222.222.222-22', '11999990002', '1988-08-20', 'Santo André'),
('Mariana Lima', 'mariana@email.com', '333.333.333-33', '11999990003', '2000-02-15', 'Osasco');

-- Inserção de quartos
INSERT INTO quartos (numero, tipo, capacidade, preco_diaria, status, descricao)
VALUES
('101', 'Simples', 1, 150.00, 'Disponível', 'Quarto individual'),
('102', 'Duplo', 2, 250.00, 'Disponível', 'Quarto para duas pessoas'),
('103', 'Luxo', 3, 400.00, 'Disponível', 'Quarto com varanda');

-- Inserção de funcionários
INSERT INTO funcionarios (nome, cargo, email, telefone)
VALUES
('Roberto Alves', 'Recepcionista', 'roberto@hotel.com', '11988880001'),
('Juliana Costa', 'Gerente', 'juliana@hotel.com', '11988880002');

-- Inserção de serviços
INSERT INTO servicos (nome, descricao, preco)
VALUES
('Café da manhã', 'Café da manhã completo', 35.00),
('Lavanderia', 'Serviço de lavagem de roupas', 25.00),
('Spa', 'Acesso aos serviços de spa', 80.00);

-- Inserção de reservas
INSERT INTO reservas (id_hospede, id_quarto, data_checkin, data_checkout, status, data_reserva)
VALUES
(1, 1, '2026-11-01', '2026-11-03', 'Concluída', '2026-10-20 10:00:00'),
(2, 2, '2026-11-05', '2026-11-07', 'Concluída', '2026-10-22 14:00:00'),
(3, 3, '2026-11-10', '2026-11-12', 'Cancelada', '2026-10-25 09:00:00');

-- Inserção de hospedagens
INSERT INTO hospedagens (id_reserva, id_funcionario, checkin_real, checkout_real, observacoes)
VALUES
(1, 1, '2026-11-01 14:00:00', '2026-11-03 12:00:00', 'Hospedagem concluída'),
(2, 2, '2026-11-05 14:00:00', '2026-11-07 12:00:00', 'Hospedagem concluída');

-- Inserção de pagamentos
INSERT INTO pagamentos (id_hospedagem, valor, metodo, data_pagamento, status_pagamento)
VALUES
(1, 395.00, 'Cartão', '2026-11-03 12:00:00', 'Pago'),
(2, 650.00, 'Pix', '2026-11-07 12:00:00', 'Pago');

-- Inserção de serviços consumidos
INSERT INTO hospedagem_servicos (id_hospedagem, id_servico, quantidade, valor_unitario)
VALUES
(1, 1, 2, 35.00),
(1, 2, 1, 25.00),
(2, 1, 2, 35.00),
(2, 3, 1, 80.00);

-- Inserção de avaliações
INSERT INTO feedbacks (id_hospedagem, nota, comentario, data_feedback)
VALUES
(1, 5, 'Ótimo atendimento e quarto confortável.', '2026-11-03 13:00:00'),
(2, 4, 'Boa hospedagem e bons serviços.', '2026-11-07 13:00:00');