# 🏍️ Projeto Mottu Monitoramento – Banco de Dados Oracle

## 📌 Descrição
Este projeto implementa um **banco de dados relacional em Oracle SQL** para gerenciar o processo de monitoramento, aluguel e manutenção de motos em diferentes filiais.  
Ele contempla **tabelas normalizadas, funções PL/SQL, procedures, triggers de auditoria e dados de teste** para simulação.

---

## 🗄️ Estrutura do Banco de Dados
As principais entidades do sistema são:

- **T_CM_PAIS / T_CM_ESTADO / T_CM_CIDADE / T_CM_BAIRRO / T_CM_LOGRADOURO**  
  Hierarquia de localização dos clientes.

- **T_CM_CLIENTE**  
  Dados cadastrais dos clientes (nome, CPF, e-mail, endereço).

- **T_CM_MODELO**  
  Modelos de motos disponíveis.

- **T_CM_FILIAL_DEPARTAMENTO**  
  Filiais e departamentos que gerenciam as motos.

- **T_CM_MOTO**  
  Informações de cada moto (modelo, filial, placa, status, km rodado).

- **T_CM_ALUGUEL**  
  Registro de aluguéis de motos, relacionando cliente, moto e período.

- **T_CM_POSICAO_MOTO**  
  Posição das motos em setores específicos da filial.

- **T_CM_MANUTENCAO**  
  Histórico de manutenções realizadas nas motos.

- **T_CM_IMAGEM_REGISTRO**  
  Registro de imagens vinculadas às posições das motos.

- **T_CM_SENSOR_RFID / T_CM_LOCALIZACAO_MOTO_RFID**  
  Sensores RFID que monitoram a localização das motos em tempo real.

- **T_AUDITORIA_DML**  
  Tabela de auditoria para registrar alterações (INSERT/UPDATE/DELETE) em aluguéis.

---

## ⚙️ Funcionalidades Implementadas

### 🔹 Funções
- **FN_ALUGUEL_JSON**  
  Retorna um aluguel em formato **JSON**, com informações de cliente, moto, modelo e filial.  
  Trata exceções como `NO_DATA_FOUND`, `TOO_MANY_ROWS` e `VALUE_ERROR`.

- **FN_VALIDAR_SENHA_COMPLEXIDADE**  
  Valida regras de senha: mínimo de 8 caracteres, letras maiúsculas/minúsculas, dígito e caractere especial.  
  Retorna mensagens de erro personalizadas.

### 🔹 Procedures
- **PRC_ALUGUEL_EM_JSON**  
  Executa a função `FN_ALUGUEL_JSON` e exibe o resultado.  
  Útil para testes e integração com aplicações.

- **PRC_RESUMO_KM_POR_FILIAL_MODELO**  
  Gera um relatório com **somatório de km rodados** por filial e modelo de moto, incluindo subtotais e total geral.

### 🔹 Trigger
- **TRG_AUD_T_CM_ALUGUEL**  
  Auditoria automática de operações **INSERT, UPDATE e DELETE** na tabela `T_CM_ALUGUEL`, salvando o estado antigo e novo em formato JSON.

---

## 📊 Exemplos de Uso

### Retornar aluguel em JSON
```sql
BEGIN
  PRC_ALUGUEL_EM_JSON(1);
END;
```

### Resumo de quilometragem
```sql
BEGIN
  PRC_RESUMO_KM_POR_FILIAL_MODELO;
END;
```

### Validação de senha
```sql
SELECT FN_VALIDAR_SENHA_COMPLEXIDADE('Abcdef1!') FROM dual;
```

### Auditoria
```sql
INSERT INTO T_CM_ALUGUEL (id_aluguel, id_cliente, id_moto, dt_retirada, dt_devolucao)
VALUES (9001, 1, 1, SYSTIMESTAMP, NULL);

UPDATE T_CM_ALUGUEL SET dt_devolucao = SYSTIMESTAMP WHERE id_aluguel = 9001;

DELETE FROM T_CM_ALUGUEL WHERE id_aluguel = 9001;
```

Consultar auditoria:
```sql
SELECT * FROM T_AUDITORIA_DML WHERE nm_tabela = 'T_CM_ALUGUEL';
```

---

## 🚀 Tecnologias Utilizadas
- **Oracle Database 19c+**
- **PL/SQL**
- **Triggers e Funções**
- **DBMS_OUTPUT** para relatórios
- **JSON manual** para integração

---

## 👨‍💻 Autor
  **Leonardo Bianchi – RM 558576**     
  **Angello Turano da Costa - RM556511**  
  **Cauã Sanches de Santana - RM558317**    
FIAP – Mastering Relational & Non-Relational Databases  
