# Banco de Dados de Carros

Este projeto consiste no desenvolvimento de um banco de dados profissional a partir de um dataset de vendas de carros dos Estados Unidos. O trabalho abrange desde o polimento do dataset até a criação de estruturas avançadas no banco de dados, seguindo o cronograma descrito na imagem abaixo:

![image](https://github.com/user-attachments/assets/3ce10d01-3ef5-40ed-bedf-e7a077c1f090)

<!--# Cronograma do Projeto
ficou estranho :(
| **Entrega**       | **Tarefa**                                     | **Descrição**                              |
|--------------------|-----------------------------------------------|--------------------------------------------|
| **Entrega 1**     | **1A**                                        | Normalização do DataSet                    |
|                   | **1B**                                        | Confecção do dicionário de dados           |
|                   | **1C**                                        | Criação de Sequences e Triggers            |
|                   | **1D**                                        | Povoamento da base de dados                |
|                   | **1E**                                        | Consultas estratégicas                     |
| **Entrega 2**     | **2A**                                        | Tabelas de histórico                       |
|                   | **2B**                                        | Triggers de historimento                   |
|                   | **2C**                                        | Historimento da carga 1 e cargas 2 e 3     |
|                   | **2D**                                        | Consultas estratégicas                     |
| **Entrega 3**     | **3A**                                        | Criação do usuário para auditoria          |
|                   | **3B**                                        | Criação da tabela de auditoria             |
|                   | **3C**                                        | Criação de Sequence e Trigger para auditoria |
|                   | **3D**                                        | Criação da procedure de auditoria          |
|                   | **3E**                                        | Criação dos triggers para auditoria        |
| **Entrega 4**     | **4A**                                        | Criação do usuário para DW                 |
|                   | **4B**                                        | Criação de views dinâmicas                 |
|                   | **4C**                                        | Criação de views materializadas            |
|                   | **4D**                                        | Consultas estratégicas                     |
| **Entrega 5**     | **5A**                                        | Certificado do curso de Power BI           |
|                   | **5B**                                        | Dashboard de análise no Power BI           |-->

## Descrição do Projeto

### 1. **Escolha e Análise do Dataset**
Começamos com a seleção de um dataset contendo informações sobre vendas de carros nos Estados Unidos. Esse dataset foi escolhido por conter uma diversidade de dados que exigiam tratamento cuidadoso, como dados incompletos, redundâncias e inconsistências. Antes de qualquer manipulação, foi feita uma análise inicial para identificar padrões e compreender como os dados poderiam ser estruturados em um banco de dados.

### 2. **Polimento dos Dados**
O dataset passou por uma etapa de limpeza, onde:
- Removemos duplicatas e valores inconsistentes.
- Tratamos dados ausentes com técnicas apropriadas, como substituições ou exclusões.
- Padronizamos os campos, como datas, estados e categorias de veículos.

Esse processo garantiu que os dados estivessem prontos para a normalização e carregamento no banco de dados.

### 3. **Normalização**
A normalização foi uma das partes mais importantes do projeto. Dividimos os dados em tabelas menores e independentes, eliminando redundâncias e garantindo a integridade dos dados. Essa etapa incluiu a definição de relações claras entre tabelas, como chaves primárias e estrangeiras.

### 4. **Modelagem e Criação do Banco**
Com os dados normalizados, realizamos a modelagem do banco de dados relacional, que incluía:
- Criação de tabelas bem estruturadas.
- Definição de restrições, como integridade referencial, chaves primárias e índices.
- Implementação de sequences e triggers para automatizar processos no banco.

### 5. **Historiamento e Auditoria**
Implementamos triggers e procedures para automatizar funções como:
- Registro de alterações nos dados para fins de auditoria.
- Atualizações automáticas em tabelas derivadas ou relacionadas.
- Validação de entradas para evitar erros durante o carregamento de novos dados.

Essas soluções trouxeram maior robustez e confiabilidade ao sistema.

### 6. **Análise e Integração**
O banco de dados foi projetado para permitir consultas estratégicas rápidas e precisas. Criamos visualizações por meio do Power BI, que incluíram dashboards para análises detalhadas, como:
- Tendências de vendas ao longo do tempo.
- Comparação de vendas por estado ou categoria de veículos.
- Identificação de padrões que poderiam auxiliar na tomada de decisões.

---

## Aprendizados e Desafios

### **Principais Desafios**
- **Tratamento de dados brutos:** A diversidade e a inconsistência do dataset inicial exigiram um trabalho meticuloso de limpeza e transformação.
- **Modelagem avançada:** Garantir que o banco atendesse a padrões profissionais de performance e escalabilidade foi um desafio significativo.
- **Automatização e auditoria:** A implementação de triggers e procedures foi um processo técnico e detalhado, mas essencial para atender aos objetivos do projeto.

### **Principais Aprendizados**
- O trabalho em um projeto do início ao fim reforçou a importância da organização e da documentação em todas as etapas.
- O uso de ferramentas de visualização como o Power BI destacou o valor da integração entre banco de dados e análise estratégica.
- A prática de normalização e implementação de regras de integridade mostrou como boas práticas podem evitar problemas futuros.

---

## Tecnologias e Ferramentas

- **Modelagem:** Oracle Data Modeler.  
- **Banco de Dados:** Oracle SQL Developer.  
- **Ferramentas de data science:** Jupyters, Python.  
- **Visualização:** Power BI.

---

## Conclusão

Este projeto demonstrou o processo completo de construção de um banco de dados relacional a partir de um dataset bruto, culminando em uma solução robusta e integrada. O resultado final foi um banco otimizado para análise estratégica, capaz de suportar consultas eficientes e oferecer insights valiosos por meio de dashboards dinâmicos.

Este projeto demonstra habilidades avançadas em modelagem, manipulação de dados e análise estratégica, representando uma solução completa para o gerenciamento de dados de vendas.
