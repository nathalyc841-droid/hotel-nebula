USE hotel_nebula;

CREATE TABLE `hospedes` (
  `id_hospede` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `endereco` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_hospede`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `quartos` (
  `id_quarto` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `capacidade` int DEFAULT NULL,
  `preco_diaria` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`id_quarto`),
  UNIQUE KEY `numero` (`numero`),
  CONSTRAINT `quartos_chk_1` CHECK ((`capacidade` > 0)),
  CONSTRAINT `quartos_chk_2` CHECK ((`preco_diaria` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `funcionarios` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `servicos` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_servico`),
  CONSTRAINT `servicos_chk_1` CHECK ((`preco` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_hospede` int DEFAULT NULL,
  `id_quarto` int DEFAULT NULL,
  `data_checkin` date NOT NULL,
  `data_checkout` date NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `data_reserva` datetime NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `id_hospede` (`id_hospede`),
  KEY `id_quarto` (`id_quarto`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_hospede`) REFERENCES `hospedes` (`id_hospede`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_quarto`) REFERENCES `quartos` (`id_quarto`),
  CONSTRAINT `reservas_chk_1` CHECK ((`data_checkout` > `data_checkin`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hospedagens` (
  `id_hospedagem` int NOT NULL AUTO_INCREMENT,
  `id_reserva` int DEFAULT NULL,
  `id_funcionario` int DEFAULT NULL,
  `checkin_real` datetime DEFAULT NULL,
  `checkout_real` datetime DEFAULT NULL,
  `observacoes` text,
  PRIMARY KEY (`id_hospedagem`),
  UNIQUE KEY `id_reserva` (`id_reserva`),
  KEY `id_funcionario` (`id_funcionario`),
  CONSTRAINT `hospedagens_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  CONSTRAINT `hospedagens_ibfk_2` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pagamentos` (
  `id_pagamento` int NOT NULL AUTO_INCREMENT,
  `id_hospedagem` int DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `metodo` varchar(30) DEFAULT NULL,
  `data_pagamento` datetime NOT NULL,
  `status_pagamento` varchar(20) NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  KEY `id_hospedagem` (`id_hospedagem`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`id_hospedagem`) REFERENCES `hospedagens` (`id_hospedagem`),
  CONSTRAINT `pagamentos_chk_1` CHECK ((`valor` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedbacks` (
  `id_feedback` int NOT NULL AUTO_INCREMENT,
  `id_hospedagem` int DEFAULT NULL,
  `nota` int NOT NULL,
  `comentario` text,
  `data_feedback` datetime NOT NULL,
  PRIMARY KEY (`id_feedback`),
  KEY `id_hospedagem` (`id_hospedagem`),
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`id_hospedagem`) REFERENCES `hospedagens` (`id_hospedagem`),
  CONSTRAINT `feedbacks_chk_1` CHECK ((`nota` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hospedagem_servicos` (
  `id_hospedagem` int NOT NULL,
  `id_servico` int NOT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_hospedagem`,`id_servico`),
  KEY `id_servico` (`id_servico`),
  CONSTRAINT `hospedagem_servicos_ibfk_1` FOREIGN KEY (`id_hospedagem`) REFERENCES `hospedagens` (`id_hospedagem`),
  CONSTRAINT `hospedagem_servicos_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`),
  CONSTRAINT `hospedagem_servicos_chk_1` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
