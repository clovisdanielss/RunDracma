### Projeto Run-Dracma

Essse projeto em ShellScript tem como objetivo facilitar a execução dos microserviços do Dracma

#### Requisitos

- Qualquer terminal com bash (Eu uso o git bash)
- Ter todos os projetos do dracma em um mesmo diretório (O meu ta no Repos padrão do VS)
- Como o script cria e demanda alguns arquivos (path.config, all.config, default.config) recomendo que coloque ele em uma pasta sozinho com os arquivos.

#### Uso

O comando funciona na forma:
```sh
    ./run-dracma
```
Nesse caso, o .sh vai pedir o diretório onde estão localizados os projetos do Dracma. Com isso ele vai criar um `path.config` e seguir sua execução. 

Se não houver argumentos, ele vai rodar para todos os projetos descritos no default.config.

Também é possível especificar algumas flags:

- (-p NomeDaPastaDoProjeto) roda o projeto específicado.
- (-b NomeDaBranch) roda o projeto especificado (ou não) na branch especificada.
- (-a) roda todos os projetos que foram definidos em um arquivo all.config.
- (-l) vê todas as pastas contidas no diretório definido do Dracma e fecha o programa.  

#### Caso de uso

```sh
./run-dracma.sh -p Financial.GUI -p Financial.Auth -p Financial.Core -b master
```
Roda os projetos GUI, AUTH, CORE na branch master.

#### all.config e default.config

É um arquivo txt simples com os nomes das pastas do projeto separado por ", ".

```
Financial.Auth, Financial.FiscalBr, clearkeeping, clearkeeping.auto, Financial.Ingress, Financial.NotificationCenter, Financial.Payment, Financial.GUI, Financial.Gateway, Financial.FileStorage, Financial.CustomerIntelligence, Financial.Core, FDM
```