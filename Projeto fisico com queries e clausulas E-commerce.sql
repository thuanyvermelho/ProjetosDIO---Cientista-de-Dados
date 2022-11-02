use ecommerce;
-- Quantos pedidos foram feitos por cada cliente?
select c.idClient, Fname, count(*) as Number_of_orders from client c
              inner join orders o on c.idClient = o.idOrderClient
              group by idClient;
            
-- Algum vendedor também é fornecedor?
select s.SocialName, s.CNPJ, ss.SocialName, ss.CNPJ from seller s, supplier ss
	where s.CPF_CNPJ = ss.CNPJ;

-- Relação de produtos e fornecedor:
select idProduct, Pname, ss.SocialName, CNPJ from product
		inner join productSupplier on idProduct = idProduct
        inner join supplier ss on idSupplier = idPsProduct;

-- Relação de Produto e Estoque:
select idProduct, Pname, st.SocialName, st.stocklocation, qs.quantitystock from product
		inner join productstock pss on idProduct =idEsProduct
        inner join stock e on idStock = idsstock
        order by st.stocklocation, Pname;

desc productsupplier;

-- Relação de nomes dos fornecedores e nomes dos produtos:
select ss.SocialName, p.Pname from Supplier ss
		inner join idPsProduct ps on idSupplier = idPsSupplier
        inner join product p on idProduct= idPsProduct;

-- Quantos clientes cadastrados?
select count(*) from client;

-- Quantos pedidos foram feitos por cliente?
select c.idClient, Fname, count(*) as Number_of_orders from client c
              inner join orders o on c.idClient = o.idOrderClient
              group by idClient;
              
-- recuperar dados do pedido e concatenar nome do cliente
select concat(Fname,' ',Lname) as client , idOrder as Request, OrderStatus as Order_Status from client c, orders o where c.idClient = idOrderClient;