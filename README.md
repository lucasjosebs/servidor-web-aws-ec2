# servidor-web-aws-ec2
Laboratório prático de provisionamento e gerenciamento de instâncias Amazon EC2. Inclui configuração de Servidor Web (Apache), Security Groups, monitoramento CloudWatch e escalabilidade vertical.

# AWS Lab: Introdução ao Amazon EC2

Este repositório contém a documentação e o passo a passo do laboratório prático de introdução ao **Amazon Elastic Compute Cloud (EC2)**. O objetivo foi aprender a lançar, configurar, monitorar e redimensionar servidores virtuais na nuvem AWS.

## 🚀 O que foi implementado
Neste laboratório, realizei as seguintes tarefas:
* **Provisionamento:** Lançamento de uma instância EC2 (Linux) com proteção contra encerramento.
* **Automação:** Uso de *User Data* (scripts de inicialização) para instalar e configurar um servidor web Apache automaticamente.
* **Segurança:** Configuração de *Security Groups* para controlar o tráfego de entrada (Porta 80 - HTTP).
* **Monitoramento:** Análise de status e métricas através do CloudWatch e captura de tela do console.
* **Escalabilidade Vertical:** Redimensionamento de tipo de instância (t3.micro para t3.small) e expansão de volume de armazenamento EBS.

## 🛠️ Tecnologias Utilizadas
* **AWS EC2** (Instâncias de computação)
* **Amazon EBS** (Armazenamento de bloco)
* **Amazon CloudWatch** (Monitoramento)
* **Apache Web Server** (Servidor HTTP)

## 📋 Passo a Passo

### 1. Lançamento da Instância
A instância foi configurada com a AMI **Amazon Linux 2023** e tipo **t3.micro**. [cite_start]Foi ativada a **Proteção contra Encerramento** para evitar exclusões acidentais[cite: 42, 43].

> **Momento para Print 1:** Tela de resumo das configurações da instância antes de clicar em "Launch" (Executar).

### 2. Automação com User Data
Utilizei o script abaixo para que a instância já subisse como um servidor web funcional:
```bash
#!/bin/bash
yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo '<html><h1>Hello From Your Web Server!</h1></html>' > /var/www/html/index.html
[cite_start]``` [cite: 101, 102, 111]

### 3. Ajuste de Segurança (Firewall)
Inicialmente, o servidor não estava acessível. Foi necessário editar as **Inbound Rules** do Security Group para permitir tráfego na porta **80 (HTTP)** vindo de qualquer lugar (0.0.0.0/0)[cite: 162, 172, 173].

> **Momento para Print 2:** A regra de entrada (Inbound Rule) configurada no Security Group e, em seguida, a página "Hello From Your Web Server!" aberta no navegador.

### 4. Redimensionamento e Armazenamento
Para simular uma necessidade de maior performance:
1. A instância foi interrompida[cite: 187].
2. O tipo de instância foi alterado de **t3.micro** para **t3.small**[cite: 193, 194].
3. O volume EBS foi expandido de **8 GiB** para **10 GiB**[cite: 200, 201].

> **Momento para Print 3:** Tela de "Modify Volume" ou a tabela de instâncias mostrando o novo tipo (t3.small).

---

## 🧹 Limpeza de Recursos
Ao final, a proteção contra encerramento foi desativada para permitir a exclusão da instância e evitar custos desnecessários[cite: 218, 219].
