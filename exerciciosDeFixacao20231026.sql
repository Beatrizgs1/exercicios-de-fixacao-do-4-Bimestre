--EXERCÍCIOS DE FIXAÇÃO:
--1.Crie um trigger que, após inserir um novo cliente na tabela Clientes, insira uma mensagem na tabela Auditoria informando a data e hora da inserção.

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


--2.Antes de excluir um cliente da tabela Clientes, crie um trigger que insira uma mensagem na tabela Auditoria informando sobre a tentativa de exclusão.

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


--3.Após atualizar o nome de um cliente na tabela Clientes, insira uma mensagem na tabela Auditoria mostrando o nome antigo e o novo nome.

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


--4.Não permita que o nome do cliente seja atualizado para uma string vazia ou NULL. Se alguém tentar fazer isso, o trigger deve impedir a atualização e inserir uma mensagem na tabela Auditoria.

DELIMITER //
CREATE TRIGGER impede_nome_vazio_ou_null
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        INSERT INTO Auditoria (mensagem)
        VALUES ('Tentativa de atualizar nome para vazio ou NULL impedida em ' NOW());
        SET NEW.nome = OLD.nome;
    END IF;
END;
//
DELIMITER ;


--5.Em uma loja, ao inserir um novo pedido na tabela Pedidos, o estoque do produto em questão, presente na tabela Produtos, deve ser decrementado. Se o estoque ficar abaixo de 5 unidades, uma mensagem deve ser inserida na tabela Auditoria.

DELIMITER //
CREATE TRIGGER atualiza_estoque_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) < 5 THEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Baixo estoque para produto ID ', NEW.produto_id, ' em ', NOW()));
    END IF;
END;
//
DELIMITER ;
