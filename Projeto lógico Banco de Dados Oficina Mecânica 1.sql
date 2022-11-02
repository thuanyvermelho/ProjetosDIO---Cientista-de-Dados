create database oficina_mecanica;
use oficina_mecanica;

create table cliente_pf(
		idClientePF int auto_increment primary key,
		Nomecompleto varchar(45) not null,
		CPF CHAR(11) NOT NULL,
        Data_nascimento date not null,
		Endereco varchar(45) not null
);

create table cliente_pj(
		idClientePJ int auto_increment primary key,
		Razaosocial varchar(45) not null,
		CNPJ char(14) not null,
	   Endereco_empresa varchar(45) not null
);

create table cliente(
		idCliente int auto_increment primary key,
        idCClientePF int,
        idCClientePJ int,
        constraint fk_cliente_pf foreign key (idCClientePF) references cliente_pf(idClientePF),
        constraint fk_cliente_pj foreign key (idCClientePJ) references cliente_pj(idClientePJ)
);

create table  veiculo(
		idVeiculo int auto_increment primary key,
        idVCliente int,
        Tipo_veiculo enum('Moto', 'Carro','Caminhão') not null,
        Placa char(7) not null,
        Chassi char(17) not null,
		Ano_fabricacao char(4) not null,
        constraint unique_chassi_veiculo unique(Chassi),
        constraint fk_veiculo_cliente foreign key (idVCliente) references cliente(idCliente)
);

create table equipes(
		idEquipes int primary key,
		Especialidade varchar(45) not null
);

create table mecânicos(
		idFuncionarios int auto_increment primary key,
		idFEquipes int,
		Nome varchar(45) not null,
		CPF char(11) not null,
        Resgistro_empresa char(6) not null,
		Cargo varchar(45) not null,
        Especialidade varchar(45) not null,
        Telefone char(11) not null,
        data_contratação date not null,
		Data_nascimento date not null, 
		Endereco varchar(45) not null,		
		constraint fk_mecanicos_equipes foreign key (idFEquipes) references equipes(idEquipes)
);

create table tabela_de_precos(
		idTabela_de_precos int auto_increment primary key,
		Tipo_de_servico enum('Conserto','Revisão') not null,
        Especialidade enum('Motor', 'Cambagem', 'Eletrica', 'hidraulica') not null, 
		Pecas varchar(45),
		Quantidade_pecas_reparos float,
		Valor_mao_obra float not null
);

create table estoque_pecas(
		idEstoque_pecas int auto_increment primary key,
        Nome_peca varchar(45) not null,
        Quantidade int not null,
        Valor_unitario float not null,
        funcionario_solicitante varchar(45)
);

create table orcamento(
		idOrcamento int auto_increment primary key,
        idOCliente int,
        Numero_orcamento char(8) not null,
		Data_orcamento date not null,
        Valor_orcamento float not null,
        Validade_orcamento date not null,
        constraint fk_orcamento_cliente foreign key (idOCliente) references cliente(idCliente)
);

create table ordem_servico(
		idOrdem_servico int auto_increment primary key,
        idOSVeiculo int,
        idOSOrcamento int,
        Data_emissao date not null,
		Valor float,
        Status_ordem enum('Em andamento', 'Concluida', 'Em analise','Cancelada'),
        Data_conclusao date,
        constraint fk_ordem_veiculo foreign key (idOSVeiculo) references veiculo(idVeiculo),
        constraint fk_ordem_equipes foreign key (idOSEquipes) references equipes(idEquipes),
        constraint fk_ordem_orcamento foreign key (idOSOrcamento) references orcamento(idOrcamento)
);