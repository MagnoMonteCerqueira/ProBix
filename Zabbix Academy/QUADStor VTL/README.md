# 🖥️ How to install QUADStor VTL on Debian 12 Linux LTS

Este repositório contém um pacote completo para instalar o QUADStor VTL no Debian 12 LTS.

---
```
## 📂 Estrutura do Repositório

├── 1.QUADStor VTL
│ ├── 1 - README.md
│ └── 2 - Package/quadstor-vtl-std-3.0.79.26-debian12-x86_64.deb
│ └── 2 - Package/Install_QUADStor_VTL-Debian-12.sh
│ └── 3.Imagens
```

### ✅ Descrição das Pastas:

| Pasta | Conteúdo |
|----|----|
| **Package** | Scripts de instalação e pacote que usamos |
| **Imagens** | Imagens utilizadas no procedimento |
---


> ⚠️ **Importante:**  
Se você for utilizar as imagens em um ambiente diferente, ajuste o caminho de acordo com a estrutura do seu servidor Grafana.

---

## ⚙️ Ambiente Utilizado

- **Sistema Operacional:** Debian 12 LTS
- **ShellScript:** Scripts executados localmente no Debian
---

## 🚀 Passos Básicos de Implantação

1. Copie o **Install_QUADStor_VTL-Debian-12.sh** para o servidor Debian na pasta /tmp.
2. Execute o comando **chmod +x Install_QUADStor_VTL-Debian-12.sh**, para tornalo executavel.
3. Execute o script **./Install_QUADStor_VTL-Debian-12.sh**.
4. Importe o **template YAML** no Zabbix.
---

## 👨‍💻 Autor

**Magno M Cerqueira**  
[www.linkedin.com/in/magnomontecerqueira](https://www.linkedin.com/in/magnomontecerqueira/)

---
