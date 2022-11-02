
use ecommerce;
show tables;
desc client;
-- Inserir dados do cliente conforme as colunas :
insert into client (Fname, Minit, Lname, CPF, Address, Data_de_nascimento) 
values ('Bianca','B','Buteikis','12345678911','Rua Maraja,Centro,São Paulo-SP','1989-03-31'),
        ('Joana','B','Macedo','22345678901','Rua Conceição,Centro,Gloria de Dourados-MS','1927-04-10'),
        ('Maria','B','Aparecida','78945612332','Rua de Deus,Centro,São Bernardo do Campo-SP','1950-07-29'),
        ('Nalciza','P','Santo','96385274101','Rua Joanopolis,Centro,São Paulo-SP','1953-12-21'),
        ('Nathalie','P','Folco','96385203214','Rua Hoje,Centro,Rio de Janeiro-RJ','1988-04-04'),
        ('Mariana','M','Pereira','95184762301','Rua Maraja,Centro,Rio de Janeiro-RJ','1987-09-26');
        
select * from product;
-- 
insert into product (Pname, classification_kids, category, avaliação) values
				('Fone',false,'Eletrônico','5'),
                ('iPhone 11',false,'Eletrônico','4.9'),
                ('Bala Fini',true,'Alimentos','5'),
				('Fandangos',true,'Alimentos','3');
				
select * from orders;
select * from product;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue,paymentCash) values
				(7, default,'compra via aplicativo',null,1),
                (10, default,'compra via aplicativo',50,0),
                (12,'Confirmado',null,null,1),
                (8, default,'Compra via website',150,0);

select * from orders;
insert into productOrder (idPOProduct,idPOorder,poQuantity,poStatus) values
							(1,24,2,null),
                            (2,21,1,null),
                            (3,23,1,null);

Insert into productStorage (storageLocation,quantity) values
							('Rio de Janeiro',1000),
                            ('São Paulo',500),
                            ('São Paulo',45),
                            ('Rio de Janeiro',10),
                            ('Brasilia',5);
                            
 insert into storageLocation (idLproduct,idLstorage,location) values
							(1,2,'RJ'),
                            (2,6,'SP'),
                            (3,3,'BA');

insert into supplier (Socialname,CNPJ,contactTelephone) values
					('Almeida e Filhos','123456789103240','21987454'),
                    ('Eletronicos Silva','987456321456123','21987484');
  
insert into productSupplier (idPsSupplier, idPsProduct,quantity) values
							(2,1,500),
                            (7,2,400),
                            (8,7,3),
                            (1,8,5),
                            (1,2,10);
  
insert into seller(SocialName, CNPJ, location,contactTelephone) values
					('Tech Eletronicos','123456789654123','Rio de Janeiro','2126598'),
                    ('Botique Dorgas','582963147985147','São Paulo','11895623');
                    
insert into productSeller (idPseller,idProduct,prodQuantity) values
						(1,6,60),
                        (2,7,10);
                        
insert into supplierCompany(SocialNamesupplier, CNPJ, Address) values
				('Brasspress Transportes Urgentes Ltda','48740351000165','Rua da Gloria, Centro, São Paulo-SP'),
				('CORREIOS','34028316000103','Avenida Santo Amaro,Buarque Rio de Janeiro');

desc delivery;
insert into delivery (idSocialNamesupplier, tracking, Status_delivery,freight_value) values
				('1','A1','Em rota de entrega','2022-10-25','0'),
				('2','A2','Entregue','2022-10-31','20,00'),
				('2','A3','Aguardando produto no fornecedor','2022-10-24','15,50'),
		
select * from orders;
select * from delivery;

desc paymentCard;

insert into PaymentCard(FullName, CPF_CNPJ, NumberCard , ValidDate) values
				('Bianca B Buteikis','22345678901','1236547896548523','2022-12-31'),
				('Joana B Macedo','22345678901','3216549879874568','2030-07-10'),
				('Mariana M Pereira','95184762301','9878459685745223','2024-08-05');
				
select * from paymentCard;
				
desc payment_type;
insert into payment_type(idpaymenttypeclient, idpaymentcardtype, Pix, Boleto) values
				(8,1,1,null),
				(7,2,2),
				(3,3,null);
				
select * from client;
insert into request(idRequestClient, iddeliveryrequest, idpaymenttype, Statusrequest, requestdate) values
				('7','1','1','Entregue','compra via aplicativo','2022-09-11'),
				('8','2','2','Entregue','compra via aplicativo','2022-10-22'),
				('10','14','7','Entregue','Compra via website','2022-07-01');
                
Insert into stock(idStock, quantityStock)
				('1','45'),
                ('5','10'),
				('8','1'),
                ('3','10');
                
-- recuperar numero de clientes
select count(*) from client;

-- recuperar os dados do pedido com o registro do cliente
select * from client c,orders o where c.idClient  = idOrderClient;

-- recuperar dados do pedido e concatenar nome do cliente
select concat(Fname,' ',Lname) as client , idOrder as Request, OrderStatus as Order_Status from client c, orders o where c.idClient = idOrderClient;
               
 -- Inserir um pedido duplicado para usar a clausula group by
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue,paymentCash) values
				(7, default,'compra via aplicativo',null,1);
  
  -- Recuperação de pedido com produto associado
select * from client c
		inner join orders o on c.idClient = idOrderClient
        inner join productOrder p on p.idPOorder = o.idOrder
	    group by idClient;
               
-- Recuperar quantos pedidos foram feitos pelo cliente
select c.idClient, Fname, count(*) as Number_of_orders from client c
              inner join orders o on c.idClient = o.idOrderClient
              group by idClient;