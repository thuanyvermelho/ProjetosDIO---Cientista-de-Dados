use oficina_mecanica;

insert into cliente_pf (Nome,CPF,Data_nascimento,Endereco)
values ('Bianca Buteikis','12345678911','1989-03-31','Rua Maraja,Centro,São Paulo-SP'),
        ('Joana Macedo','22345678901','1927-04-10','Rua Conceição,Centro,Gloria de Dourados-MS'),
        ('Maria Aparecida','78945612332','1950-07-29','Rua de Deus,Centro,São Bernardo do Campo-SP'),
        ('Nalciza Santo','96385274101','1953-12-21','Rua Joanopolis,Centro,São Paulo-SP'),
        ('Nathalie Folco','96385203214','1988-04-04','Rua Hoje,Centro,Rio de Janeiro-RJ'),
        ('Mariana Pereira','95184762301','1987-09-26','Rua Maraja,Centro,Rio de Janeiro-RJ');
 				
insert into cliente_pj (Razao_social,CNPJ,Endereco_empresa)
		values ('Tech Eletronicos','123456789654123','Rua da mota,20 Rio de Janeiro-RJ'),
				('Botique Dorgas','582963147985147','Rua são joao,15 São Paulo-SP');
				
insert into cliente (idCClientePF,idCClientePJ) values
		(1,null),
		(2,null),
		(3,null),
		(4,null),
		(5,null),
        (6,null);
		
insert into veiculo (idVCliente,Tipo_veiculo,Placa,CHASSI,Ano_fabricacao) 
        VALUES ('1','Carro','ABC1234','78965412396385274','2020'),
		('2','Moto','DEF1234','78945612345678963','2020'),
		('3','caminhão','GHI1233','78965412365897452','2022'),
		('4','Caminhão','JKL1234','78965874123658974','2018'),
		('5','Caminhão','MNO7899','12345678912345678''2019');
        
insert into equipes (idEquipes,Especialidade) 
values  ('1','Motor'),
		('2','Cambagem'),
		('3','Eletrica'),
		('4','hidraulica');

insert into mecanicos (idFEquipes,Resgistro_empresa,Nome,CPF,Cargo,Especialidade, Telefone,Data_contratacao,Data_nascimento ,Endereco)
		values ('1','0001','Paulo Jose','11111111111','Chefe Mecânica','Motor','2014-07-10','1980-01-30','Rua das Palmeiras São Paulo'),
				('2','0002','Pedro Guimarâes','22222222222','Mecânico','eletrica','2022-01-05','1989-09-20','Rua São João São Paulo-SP'),
				('3','0003','Ernesto João','33333333333','Mecânico','hidraulica','2019-09-22','1975-05-11','Rua da gloria São Bernardo do Campo-SP'),
				('4','0004','Matheus Henrique','44444444444',',Mecânico','Cambagem','2015-12-01','1988-02-17','Rua Barão da Serra Santo André-SP');

insert into tabela_de_precos (Tipo_de_servico,Especialidade,Pecas,Quantidade_pecas,Valor_mao_obra) 
values 	('Conserto','eletrica','2','1204.00'),
		('Revisão','Motor','2','250.00'),
		('Conserto','Motor','1','1000.00');

insert into estoque_pecas (Nome_peca,Quantidade_disponivel,Valor_unitario,funcionario_solicitante) 
values 	('caixa de som comleta','2','300.00','Pedro Guimarâes'),
		('troca de oleo','2','100,00','João Silva'),
		('troca do motor','1','5000.00','Paulo Jose');
		
insert into orcamento (idOCliente,Numero_orcamento,Data_orcamento,Valor_orcamento,Validade_orcamento) 
values 	('1','100001','2022-10-08','1504.00','2022-10-20'),
		('3','100002','2022-10-11','350.00','2022-10-28'),
		('4','100003','2022-10-30','6000.00','2022-11-05');
		
		
insert into ordem_servico (idOSVeiculo,idOSEquipes,idOSOrcamento,Data_emissao,Valor,Status_ordem,Data_conclusao) 
values 	('1','3','00178','2022-10-08','1504.00','Concluida','2022-10-30'),
		('2','3','00180','2022-10-11','350.00','concluida',2022-10-20),
		('3','1','00190','2022-10-30','6000.00','Cancelada',null);