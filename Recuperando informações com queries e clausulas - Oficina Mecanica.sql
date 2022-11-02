use oficina_mecanica;

-- Qual(is) os tipos de veiculos de cada cliente pessoa Fisica?
select nome, placa, Tipo_veiculo from cliente_pf
		inner join cliente on idClientePF = idCClientePF
        inner join veiculo on idcliente = idVCliente
        order by nome;
             
-- Quantas Ordem de Serviço existem?
select count(*) from ordem_servico;

-- Quais os clientes possuem Caminhão?
select nome, Tipo_veiculo from cliente_pf
		inner join cliente on idClientePF = idCClientePF
        inner join veiculo on idcliente = idVCliente
        having Tipo_veiculo = "caminhão";
       
        
-- Quantas OS foram Concluidas?
select count(*) from ordem_servico where Status_ordem = 'Concluida'; 

-- Recupere o nome do cliente, o tipo de veiculo e a ordem de serviço;
select pf.Nome, v.Tipo_veiculo, os.ordem_servico from cliente_pf pf
		inner join cliente c on idClientePF = idCClientePF
        inner join veiculo v on idCliente = idVCliente
        inner join orcamento o on idCliente = idOCliente
        inner join ordem_servico os on idOrcamento = idOSOrcamento;

-- Recupere o nome dos mecânicos em cada equipe;
select m.Nome, e.especialidade from mecanicos m, equipes e where e.especialidade = m.especialidade;    
       
-- Recupere a equipe responsavel por cada veiculo;
select especialidade, tipo_veiculo, placa from equipes
		inner join ordem_servico on idEquipes = idOSEquipes
        inner join veiculo on idVeiculo = idOSVeiculo
        order by especialidade and Tipo_veiculo;
 