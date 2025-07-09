# 🎛️ Instalação e Configuração do QUADStor VTL no Debian

Este guia mostra como instalar e configurar o [QUADStor VTL](http://quadstor.com) em uma máquina Debian para emular fitas LTO virtualizadas (ex: LTO-1 a LTO-5). Ideal para testes com **Proxmox Backup Server (PBS)**, **Veeam**, **Bacula** ou qualquer software que suporte bibliotecas de fita.

---

## 📦 Requisitos

- Debian 11 ou 12 (testado no Bookworm)
- Kernel compatível (distribuição padrão estável)
- Acesso root
- Disco adicional para armazenar as fitas virtuais
- Conexão com a internet

---

## ⚙️ Passo a Passo Completo

### 1. Atualize o sistema

```bash
apt update && apt upgrade -y
```

### 2. Instale as dependências para compilação dos módulos

```bash
apt-get install uuid-runtime build-essential sg3-utils apache2 gzip xz-utils postgresql libpq-dev psmisc linux-headers-$(uname -r) -y
a2enmod cgi
```

### 3. Baixe o pacote .deb do QUADStor

```bash
cd /tmp
wget https://www.quadstor.com/vtldownloads/quadstor-vtl-ext-3.0.28-debian-x86_64.deb
```

⚠️ Se o link estiver fora do ar, consulte: http://quadstor.com/downloads.html

### 4. Instale o pacote

```bash
dpkg -i quadstor-vtl-*.deb
```

### 5. Ative e inicie o serviço QUADStor

```bash
systemctl enable quadstorvtl
systemctl restart quadstorvtl
systemctl restart apache2
```

---

## 🌐 Configuração via Web

Acesse o IP da VM pelo navegador: `http://<IP-do-servidor>/`

Uma vez instalado, você verá a interface semelhante a:

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/01.JPG)

1. Adicione discos adicionais para armazenar fitas virtuais.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/02.JPG)

2. Vá até a aba **System** e reinicie o sistema.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/03.JPG)

3. Após o reboot, acesse novamente o IP → vá até **Physical Storage** → clique em **Add**.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/04.JPG)

4. Selecione o único Storage Pool disponível e clique em **Enviar**.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/05.JPG)

5. O disco será inicializado como fita virtual.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/06.JPG)

6. Após segundos, sua fita virtual estará pronta.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/07.JPG)

---

## 🧱 Criação da Biblioteca Virtual (VTL)

1. Vá em **Virtual Libraries** → clique em **Add VTL**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/08.JPG)

2. Vá até **Device Definitions** para corrigir.

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/09.JPG)

3. Importe:
   - Changer Definitions (`.txt`)
   - Drive Definitions (`.txt`)

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/10.JPG) 
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/11.JPG)
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/12.JPG)
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/14.JPG)
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/15.JPG)

4. Volte em **Virtual Libraries** → **Add VTL**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/16.JPG)

### Configuração de exemplo:

- VTL name: `VTLQUADSTOR`
- Changer Definition: `IBM_3584`
- Drive Definition: `IBM_LTO5`
- Number of VDrives: `1`
- Number of VSlots: `20`
- Number of IE Ports: `4`

Resumo da VTL criada  
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/17.JPG)

 Fitas virtuais visíveis
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/18.JPG)
---

## 💾 Adicionando Fitas Virtuais

1. Vá em **VCartridge** → **Add VCartridge**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/19.JPG)

Exemplo:

- VTL Name: `VTLQUADSTOR`
- VCartridge Type: `LTO 5 1500GB`
- Storage Pool: `Default`
- Number of VCartridges: `20`
- Prefix: `QUAD00`

Fitas adicionadas com sucesso 
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/20.JPG)

Biblioteca virtual pronta
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/21.JPG)

---

## 🔗 Integração com Veeam Backup & Replication

1. No Veeam Server, abra o **iSCSI Initiator**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/22.JPG)

2. Adicione o IP do QUADStor VTL → Conecte os dispositivos

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/23.JPG)

3. Verifique o **Gerenciador de Dispositivos**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/24.JPG)

4. No Veeam, vá em **Tape Infrastructure** → **Add Tape Server**

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/25.JPG)

5. Use o mesmo servidor Veeam
   
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/26.JPG)

7. Configure regras de rede, se necessário

![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/27.JPG)

7. Instalação do Tape Proxy

Tape Proxy sendo instalado  
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/28.JPG)

Tarefas concluídas
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/29.JPG)

8. Finalize e visualize a estrutura

Tape Server finalizado
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/30.JPG)

Media Pool e Slots livres  
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/31.JPG)

Fita virtual conectada
![alt tag](https://github.com/MagnoMonteCerqueira/ProBix/blob/main/Zabbix%20Academy/QUADStor%20VTL/Imagens/32.JPG)

---

## 🎉 Finalização

Agora você pode configurar seus jobs de backup normalmente, utilizando a VTL como uma biblioteca de fitas física.

---

**Autor:** Magno M Cerqueira  
🔗 [www.linkedin.com/in/magnomontecerqueira](https://www.linkedin.com/in/magnomontecerqueira/)
