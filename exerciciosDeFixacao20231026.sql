--EXERCÍCIOS DE FIXAÇÃO:
--Crie um trigger que, após inserir um novo cliente na tabela Clientes, insira uma mensagem na tabela Auditoria informando a data e hora da inserção.

DELIMITER //
CREATE TRIGGER insere_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Novo cliente adicionado em ', NOW()));
END;
//
DELIMITER ;


--Antes de excluir um cliente da tabela Clientes, crie um trigger que insira uma mensagem na tabela Auditoria informando sobre a tentativa de exclusão.

DELIMITER //
CREATE TRIGGER tentativa_exclusao_cliente
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Tentativa de excluir cliente ID ', OLD.id, ' em ', NOW()));
END;
//
DELIMITER ;


--Após atualizar o nome de um cliente na tabela Clientes, insira uma mensagem na tabela Auditoria mostrando o nome antigo e o novo nome.

DELIMITER //
CREATE TRIGGER atualiza_nome_cliente
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Nome do cliente ID ', OLD.id, ' atualizado de "', OLD.nome, '" para "', NEW.nome, '" em ', NOW()));
END;
//
DELIMITER ;
