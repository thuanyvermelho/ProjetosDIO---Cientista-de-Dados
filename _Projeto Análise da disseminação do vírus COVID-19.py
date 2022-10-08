#!/usr/bin/env python
# coding: utf-8

# # Descrição - Projeto Análise  Descritiva COVID-19 - BRASIL
# 
# 
# Neste Labs, vamos investigar os dados da disseminação do COVID-19 no Brasil desde o início da pandemia em fevereiro de 2020.
# 
# Iremos estudar os padrões de disseminação da doença, investigar os números de infectados, de recuperados e de óbitos, para construir modelos com Python e Machine Learning para prever os números nos próximos dias e o ponto de virada da curva de infecção baseado em alguns cenários.
# 
# ### https://www.kaggle.com/datasets/sudalairajkumar/novel-corona-virus-2019-dataset

# In[1]:


import pandas as pd
import numpy as np
from datetime import datetime
import plotly.express as px
import plotly.graph_objects as go


# Agora, vamos importar os dados. É importante já dizer no comando pd.read_csv quais são as colunas que serão "parseadas" como datas. O pandas possui métodos robustos para trabalhar com esse tipo de informação.

# In[2]:


#importar os dados para o projeto
url = 'https://github.com/thuanyvermelho/ProjetosDIO---Cientista-de-Dados/blob/Projeto-3/covid_19_data.csv?raw=true'

#salvando as colunas abaixo com o formato data
df = pd.read_csv(url, parse_dates=['ObservationDate', 'Last Update'])
df 


# Agora, vamos conferir os tipos das variáveis para verificar que as colunas foram corretamente importadas.
# 

# In[3]:


df.dtypes


# Nomes de colunas não devem ter letras maiúsculas e nem caracteres especiais. Vamos utilizar uma função para corrigir os nomes das colunas.
# 

# In[18]:


import re
def corrige_colunas(col_name):
    return re.sub(r"[/| ]", "", col_name).lower()


# In[19]:


#corrigindo todas as colunas da df
df.columns = [corrige_colunas(col) for col in df.columns]


# In[20]:


df


# ## Análises
# 
# Agora vamos começar a investigar as variáveis que temos à disposição. Sabemos que trata-se de séries temporais que estão divididas por estado. Para fazer qualquer análise, portanto, precisamos dividir os nossos dados esse "grão".
# 
# Vamos verificar primeiro quantos estados temos informações para o Brasil.

# In[21]:


#auntidade de paises na coluna paisregiao =
df.CountryRegion.unique()


# In[23]:


# filtrar apenas a coluna Brazil
df.loc[df.countryregion == 'Brazil'] 


# No caso do Brasil, não temos informação a nível de estado, apenas a nível do país. Vamos verificar como está o comportamento dos casos confirmados no Brasil desde o primeiro caso confirmado, 26 de fevereiro

# In[24]:


#criar a variavel e filtrar apenas os casos do Brasil confirmados acima de 0 - loc busca pelo nome
Brasil = df.loc[
    (df.countryregion == 'Brazil') & (df.confirmed > 0)]
Brasil


# In[25]:


# gráfico de evolução de casos confirmados
px.line(Brasil, 'observationdate' ,'confirmed', title='Casos Confirmados no Brasil')


# ## Número de novos casos por dia

# In[26]:


# Técnica de programação funcional - lambda função anonima - iloc busca pelo indice
# calcula np.arange(Brasil.shape[0])- ontem-hoje #

Brasil['novoscasos'] = list(map(
    lambda x: 0 if (x == 0) else Brasil['confirmed'].iloc[x] - Brasil['confirmed'].iloc[x-1],
    np.arange(Brasil.shape[0])
))


# In[27]:


Brasil


# In[28]:


# visualizando o df Brasil no gráfico
px.line(Brasil, x='observationdate', y='novoscasos', title='Novos Casos por dia Brasil')


# ## Mortes

# In[31]:


#criar gráfico com escala lonhas e marcação
fig = go.Figure()

fig.add_trace(
    go.Scatter(x=Brasil.observationdate, y=Brasil.deaths, name='Mortes', mode='lines+markers',
              line=dict(color='red'))
)
#Edita o layout
fig.update_layout(title='Mortes por COVID-19 no Brasil',
                   xaxis_title='Data',
                   yaxis_title='Número de mortes')
fig.show()


# ## Taxa de Crescimento
# 
# calcular a taxa de crescimento em uma nova variavel de todo periodo avaliado
# 
# taxa_crescimento = (presenta/passado)**(1/n)- 1

# In[32]:


#calcular a taxa de crescimento em uma função def 

def taxa_crescimento(data, variable, data_inicio=None, data_fim=None ):

#se a data de inicio for none, define como a primeira data disponivel. 
#Puxar a data de inicio da coluna obervationdate acima de 0

    if data_inicio == None:
        data_inicio = data.observationdate.loc[data[variable]> 0].min()
    else:
        data_inicio = pd.to_datetime(data_inicio) #colocar em formato de data a coluna data_inicio
   
    if data_fim == None:
        data_fim = data.observationdate.iloc[-1] #-1 puxa o ultimo caso de data
    else:
        data_fim = pd.to_datetime(data_fim)
    
    #Definir os valores do presente e do passado
    passado = data.loc[data.observationdate == data_inicio, variable].values[0]
    presente = data.loc[data.observationdate == data_fim, variable].values[0]
    
    #definir o numero de pontos no tempo que vamos avaliar
    n = (data_fim - data_inicio).days
    
    #calcular a taxa
    taxa = (presente/passado)**(1/n) - 1
    return taxa*100


# In[33]:


#Taxa de crescimento médio do COVID-19 no Brasil em todo o periodo ( Fev a Maio 2020 ) - 16,2% ao dia de casos
taxa_crescimento(Brasil, 'confirmed')


# In[34]:


#Taxa de Crescimento diário
def taxa_crescimento_diaria(data, variable, data_inicio=None):
    #se a data de inicio for none, define como a primeira data disponivel. 
    #Puxar a data de inicio da coluna obervationdate acima de 0

    if data_inicio == None:
        data_inicio = data.observationdate.loc[data[variable]> 0].min()
    else:
        data_inicio = pd.to_datetime(data_inicio) #colocar em formato de data a coluna data_inicio
    
    data_fim = data.observationdate.max()
    #definir o numero de pontos no tempo que vamos avaliar
    n = (data_fim - data_inicio).days
    
    #Taxa calculada de um dia para o outro - x-1 - ontem sobre ontem menos hoje
    taxas = list(map(
        lambda x: (data[variable].iloc[x] - data[variable].iloc[x-1]) / data[variable].iloc[x-1],
        range(1, n+1)
    ))
    return np.array(taxas) * 100


# In[35]:


tx_dia = taxa_crescimento_diaria(Brasil, 'confirmed')
tx_dia


# In[36]:


primeiro_dia = Brasil.observationdate.loc[Brasil.confirmed > 0].min()
px.line(x=pd.date_range(primeiro_dia, Brasil.observationdate.max())[1:],
       y=tx_dia, title="Taxa de crescimento de casos confirmados no Brasil")


# ## Predições
# 
# 

# In[37]:


from statsmodels.tsa.seasonal import seasonal_decompose
import matplotlib.pyplot as plt


# In[38]:


confirmados = Brasil.confirmed
confirmados.index = Brasil.observationdate
confirmados


# In[ ]:


res2 = seasonal_decompose(confirmados)

fig, (ax1,ax2,ax3, ax4) = plt.subplots(4, 1,figsize=(10,8))
ax1.plot(res.observed)
ax2.plot(res.trend)
ax3.plot(res.seasonal)
ax4.scatter(confirmados.index, res.resid)
ax4.axhline(0, linestyle='dashed', c='black')
plt.show()


# ## ARIMA

# In[39]:


get_ipython().system('pip install pmdarima')


# In[40]:


from pmdarima.arima import auto_arima
modelo = auto_arima(confirmados)


# In[44]:


fig = go.Figure(go.Scatter(
    x=confirmados.index, y=confirmados, name='Observed'
))

fig.add_trace(go.Scatter(
    x=confirmados.index, y = modelo.predict_in_sample(), name='Predicted'))

fig.add_trace(go.Scatter(
    x=pd.date_range('2020-05-20','2020-06-20'), y=modelo.predict(30), name='Forecast'))

fig.update_layout(title='Previsão de casos confirmados para os próximos 30 dias',
                 yaxis_title='Casos confirmados', xaxis_title='Data')
fig.show()

