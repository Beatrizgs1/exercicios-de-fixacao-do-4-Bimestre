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
