
ALTER SCHEMA `restaurante`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `restaurante`.`Usuario` (
  `idUsuario` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Login` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(30) NOT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  `Endereço_idEndereço` INT(11) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idCliente_UNIQUE` (`idUsuario` ASC) ,
  UNIQUE INDEX `Cpf_UNIQUE` (`Senha` ASC) ,
  INDEX `fk_Usuario_Cliente1_idx` (`Cliente_idCliente` ASC) ,
  INDEX `fk_Usuario_Endereço1_idx` (`Endereço_idEndereço` ASC),
  CONSTRAINT `fk_Usuario_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `restaurante`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Endereço1`
    FOREIGN KEY (`Endereço_idEndereço`)
    REFERENCES `restaurante`.`Endereço` (`idEndereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Pedido` (
  `idPedido` INT(10) UNSIGNED NOT NULL,
  `Tempo_de_Entrega` DATETIME NOT NULL,
  `Funcionario_idFuncionario` INT(10) UNSIGNED NOT NULL,
  `Usuario_idUsuario` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) ,
  INDEX `fk_Pedido_Usuario1_idx` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Pedido_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `restaurante`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `restaurante`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Funcionario` (
  `idFuncionario` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `Data_Admissão` DATE NULL DEFAULT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_Cliente1_idx` (`Cliente_idCliente` ASC) ,
  CONSTRAINT `fk_Funcionario_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `restaurante`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Endereço` (
  `idEndereço` INT(11) NOT NULL,
  `Cidade` VARCHAR(45) NULL DEFAULT NULL,
  `Logradouro` VARCHAR(45) NULL DEFAULT NULL,
  `Cep` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idEndereço`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Reserva` (
  `idReserva` INT(11) NOT NULL,
  `Hora_data` VARCHAR(45) NOT NULL,
  `Mesa_idMesa` INT(11) NOT NULL,
  `Usuario_idUsuario` INT(10) UNSIGNED NOT NULL,
  INDEX `fk_Reserva_Mesa1_idx` (`Mesa_idMesa` ASC) ,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Usuario1_idx` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Reserva_Mesa1`
    FOREIGN KEY (`Mesa_idMesa`)
    REFERENCES `restaurante`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `restaurante`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Pagamento` (
  `idPagamento` INT(11) NOT NULL,
  `Data_pagamento` DATETIME NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Usuario_idUsuario` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Usuario1_idx` (`Usuario_idUsuario` ASC) ,
  CONSTRAINT `fk_Pagamento_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `restaurante`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Mesa` (
  `idMesa` INT(11) NOT NULL,
  `Quantidade_lugares` INT(11) NOT NULL,
  PRIMARY KEY (`idMesa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Prato` (
  `idPrato` INT(11) NOT NULL,
  `Valor` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Bebida` (
  `idBebida` INT(11) NOT NULL,
  `Valor` INT(11) NULL DEFAULT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBebida`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Cliente` (
  `idCliente` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cpf` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Cpf_UNIQUE` (`Cpf` ASC) ,
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Prato_has_Pedido` (
  `Prato_idPrato` INT(11) NOT NULL,
  `Pedido_idPedido` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Prato_idPrato`, `Pedido_idPedido`),
  INDEX `fk_Prato_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) ,
  INDEX `fk_Prato_has_Pedido_Prato1_idx` (`Prato_idPrato` ASC) ,
  CONSTRAINT `fk_Prato_has_Pedido_Prato1`
    FOREIGN KEY (`Prato_idPrato`)
    REFERENCES `restaurante`.`Prato` (`idPrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prato_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `restaurante`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `restaurante`.`Bebida_has_Pedido` (
  `Bebida_idBebida` INT(11) NOT NULL,
  `Pedido_idPedido` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Bebida_idBebida`, `Pedido_idPedido`),
  INDEX `fk_Bebida_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) ,
  INDEX `fk_Bebida_has_Pedido_Bebida1_idx` (`Bebida_idBebida` ASC) ,
  CONSTRAINT `fk_Bebida_has_Pedido_Bebida1`
    FOREIGN KEY (`Bebida_idBebida`)
    REFERENCES `restaurante`.`Bebida` (`idBebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bebida_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `restaurante`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

select * from prato;
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('3', '30', 'galeto');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('4', '25', 'Sushi');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('5', '40', 'espaguete');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('6', '48', 'picanha');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('7', '50', 'picanha argentina');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('8', '45', 'filé');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('9', '35', 'camarão');
INSERT INTO `restaurante`.`prato` (`idPrato`, `Valor`, `Nome`) VALUES ('10', '34', 'churrasco misto');

select * from bebida;
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('11', '14', 'whisck');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('22', '8', 'vodka');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('33', '6', 'cerveja');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('44', '13', 'tequila');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('55', '8', 'vinho tinto');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('66', '4', 'montila');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('77', '11', 'conhaque');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('88', '15', 'licor');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('99', '20', 'barcadir');
INSERT INTO `restaurante`.`bebida` (`idBebida`, `Valor`, `Nome`) VALUES ('100', '9', 'vinho branco');

select * from cliente;
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('1', 'Eduardo bocao', '11111');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('2', 'José play', '22222');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('3', 'Latony', '33333');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('4', 'Rodrigo', '44444');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('5', 'Marcos machuca', '55555');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('6', 'Will', '66666');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('7', 'Amanda', '77777');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('8', 'Renata', '88888');
INSERT INTO `restaurante`.`cliente` (`idCliente`, `Nome`, `Cpf`) VALUES ('9', 'Talysson', '99999');

select * from usuario;
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('1', '@Bocao', '1212', '1', '111');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('2', '@jc', '1313', '2', '222');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('3', '@latony', '1414', '3', '333');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('4', '@rodriguete', '1515', '4', '444');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('5', '@machuca', '1616', '5', '555');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('6', '@willmaxixi', '1717', '6', '666');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('7', '@mandinha', '1818', '7', '777');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('8', '@reh', '1919', '8', '888');
INSERT INTO `restaurante`.`usuario` (`idUsuario`, `Login`, `Senha`, `Cliente_idCliente`, `Endereço_idEndereço`) VALUES ('9', '@talysson', '2020', '9', '999');

select * from endereço;

select * from pedido;


select * from funcionario;

select * from bebida;

select * from cliente c
join usuario u 
on idcliente = idusuario;

select c.idcliente ,c.Nome, u.Login, u.Senha from cliente c
join usuario u 
on idcliente = idusuario;

ALTER TABLE `restaurante`.`pedido` 
ADD CONSTRAINT `fk_pedido_funcionario`
  FOREIGN KEY (`funcionario_idFuncionario`)
  REFERENCES `restaurante`.`funcionario` (`idFuncionario`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE funcionario DROP COLUMN funcionario_idFuncionario;

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_Funcionario
FOREIGN KEY(funcionario_idFuncionario) REFERENCES funcionario (idFuncionario);



ALTER TABLE `restaurante`.`pedido` 
ADD COLUMN `funcionario_idFuncionario` INT(10) NOT NULL AFTER `data`,
ADD INDEX `fk_pedido_funcionario1_idx` (`funcionario_idFuncionario` ASC), 
ADD CONSTRAINT `fk_pedido_funcionario1`
  FOREIGN KEY (`funcionario_idFuncionario`)
  REFERENCES `restaurante`.`funcionario` (`idFuncionario`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



