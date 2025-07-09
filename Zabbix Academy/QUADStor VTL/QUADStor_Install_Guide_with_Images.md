
# 🎛️ Instalação e Configuração do QUADStor VTL no Debian

Guia completo para instalação e configuração do [QUADStor VTL](http://quadstor.com) em ambientes **Debian 11 ou 12**, com suporte a emulação de fitas LTO (1 a 5). Ideal para testes com **Proxmox Backup Server (PBS)**, **Veeam**, **Bacula** ou qualquer outro software compatível com bibliotecas de fita.

---

## 📚 Tabela de Conteúdo

- [📦 Requisitos](#-requisitos)
- [⚙️ Passo a Passo Completo](#️-passo-a-passo-completo)
- [🌐 Configuração via Web](#-configuração-via-web)
- [🧱 Criação da Biblioteca Virtual (VTL)](#-criação-da-biblioteca-virtual-vtl)
- [💾 Adicionando Fitas Virtuais](#-adicionando-fitas-virtuais)
- [🔗 Integração com Veeam Backup & Replication](#-integração-com-veeam-backup--replication)
- [🔐 Protegendo a Interface Web](#-protegendo-a-interface-web)
- [🎉 Finalização](#-finalização)
- [👨‍💻 Autor](#-autor)

---

## 📦 Requisitos

- Debian 11 ou 12 (testado no Bookworm)
- Kernel compatível
- Permissão de root
- Disco adicional para armazenar as fitas virtuais
- Conexão com a internet

---

## ⚙️ Passo a Passo Completo

### 1. Atualize o sistema
```bash
apt update && apt upgrade -y
```

### 2. Instale as dependências
```bash
apt-get install uuid-runtime build-essential sg3-utils apache2 gzip xz-utils postgresql libpq-dev psmisc linux-headers-$(uname -r) -y
a2enmod cgi
```

### 3. Baixe o pacote do QUADStor
```bash
cd /tmp
wget https://www.quadstor.com/vtlstd/quadstor-vtl-std-3.0.79.26-debian12-x86_64.deb
```

### 4. Instale o pacote
```bash
dpkg -i quadstor-vtl-*.deb
```

### 5. Ative os serviços
```bash
systemctl enable quadstorvtl
systemctl restart quadstorvtl
systemctl restart apache2
```

---

## 🌐 Configuração via Web

Acesse: `http://<IP-do-servidor>/`

1. Adicione discos adicionais.
2. Vá até a aba **System** e reinicie o sistema.
3. Vá em **Physical Storage** → **Add**.
4. Selecione o **Storage Pool** disponível.
5. O disco será convertido em fita virtual.

---

## 🧱 Criação da Biblioteca Virtual (VTL)

1. Navegue até **Virtual Libraries** → **Add VTL**.
2. Vá para **Device Definitions** e importe:
   - `Changer Definitions (.txt)`
   - `Drive Definitions (.txt)`
3. Configure:
   - **VTL name:** `VTLQUADSTOR`
   - **Changer Definition:** `IBM_3584`
   - **Drive Definition:** `IBM_LTO5`
   - **Drives:** `1`
   - **Slots:** `20`
   - **IE Ports:** `4`

---

## 💾 Adicionando Fitas Virtuais

1. Vá para **VCartridge** → **Add VCartridge**
2. Exemplo de configuração:
   - **VTL Name:** `VTLQUADSTOR`
   - **VCartridge Type:** `LTO 5 1500GB`
   - **Storage Pool:** `Default`
   - **Number of VCartridges:** `20`
   - **Prefix:** `QUAD00`

---

## 🔗 Integração com Veeam Backup & Replication

1. Abra o **iSCSI Initiator** no servidor Veeam.
2. Conecte ao IP do QUADStor VTL.
3. Verifique os dispositivos no **Gerenciador de Dispositivos**.
4. No Veeam:
   - Vá para **Tape Infrastructure** → **Add Tape Server**
   - Selecione o servidor atual
   - Configure rede e instale o **Tape Proxy**
5. Finalize e veja a estrutura criada.

---

## 🔐 Protegendo a Interface Web

### 1. Autenticação VTL

A partir da versão 3.0.43, é possível usar autenticação nativa.

#### Adicionar configuração:
Crie ou edite `/quadstorvtl/etc/quadstor.conf`

#### Adicione usuário:
```bash
/quadstorvtl/bin/vtuser -a -u <usuario> --p <senha>
```

- 8 a 32 caracteres
- Apenas caracteres ASCII, `_` e `-` permitidos

#### Usuário somente leitura:
```bash
/quadstorvtl/bin/vtuser -a -u <usuario> --p <senha> -r
```

#### Listar usuários:
```bash
/quadstorvtl/bin/vtuser --list
```

#### Remover usuário:
```bash
/quadstorvtl/bin/vtuser -x -u <usuario>
```

---

## 🎉 Finalização

A VTL está pronta para uso em testes, homologação ou ambientes de backup reais com ferramentas como **Veeam**, **PBS**, **Bacula**, entre outros.

---

## 👨‍💻 Autor

**Magno M Cerqueira**  
🔗 [www.linkedin.com/in/magnomontecerqueira](https://www.linkedin.com/in/magnomontecerqueira/)
