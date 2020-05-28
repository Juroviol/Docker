# Docker

- [Comandos básicos](#comandos-básicos)
  - [Listar imagens baixadas](#listar-imagens-baixadas)
  - [Listar os containeres criados](#listar-os-containeres-criados)
  - [Iniciar um container parado](#iniciar-um-container-parado)
  - [Parar um container](#parar-um-container)
  - [Remover um container](#remover-uma-imagem)
  - [Remover uma imagem](#remover-uma-imagem)
  - [Iniciar uma sessão bash no container para rodar comandos bash dentro do container](#iniciar-uma-sessão-bash-no-container-para-rodar-comandos-bash-dentro-do-container)
  - [Construir uma imagem a partir do Dockerfile](#construir-uma-imagem-a-partir-do-dockerfile)
  - [Iniciar um container a partir de uma imagem](#iniciar-um-container-a-partir-de-uma-imagem)
  - [Salvar uma imagem criada em um arquivo .tar](#salvar-uma-imagem-criada-em-um-arquivo-tar)
  - [Carregar uma imagem a partir de um arquivo .tar](#carregar-uma-imagem-a-partir-de-um-arquivo-tar)
- [Exemplos de utilização](#exemplos-de-utilização)
  - [Básicos](#básicos)
    - [PostgreSQL](#postgresql)
    - [MySQL](#mysql)
  - [Avançados](#avançados)

### Comandos básicos

#### Listar imagens baixadas

```
$ docker image ls
```

#### Listar os containeres criados

```
$ docker container ls --all
```

#### Iniciar um container parado

```
$ docker container start <name>
```

#### Parar um container

```
$ docker container stop <name>
```

#### Remover um container

```
$ docker rm <name>
```

#### Remover uma imagem

```
$ docker image rmi <image_id>
```

#### Iniciar uma sessão bash no container para rodar comandos bash dentro do container

```
$ docker exec -it <container> bash
```

#### Construir uma imagem a partir do Dockerfile

```
$ docker build <directory> -t <name>
```

Onde `directory` é o diretório onde está o Dockerfile e `name` o nome da imagem que será criada.

#### Iniciar um container a partir de uma imagem

```
$ docker run --name <container-name> -d <image-name>
```

Onde `container-name` é o nome que será dado ao container, e `imagem-name` é o nome da imagem a partir do qual o container será iniciado.

#### Salvar uma imagem criada em um arquivo .tar

```
$ docker save --output <tar-name> <image-name>
```

Onde `tar-name` é o nome do arquivo tar salvado e `image-name` o nome da imagem que será salvada como .tar.

#### Carregar uma imagem a partir de um arquivo .tar

```
$ docker load --input <tar-name>
```

Onde `tar-name` é o nome do arquivo .tar 


### Exemplos de utilização

#### Básicos

##### PostgreSQL

Baixando e rodando a imagem do Postgre

1. Primeiramente é preciso baixar uma imagem do Postgre

```
$ docker pull postgres
```

2. Iniciar um container contendo a imagem do Postgres exposta na porta 5432

```
$ docker run --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres
```

Pronto agora você está pronto para utilizar o Postgres.

**Opcional**: Iniciar um container contendo a imagem do Postgres com script .sql de inicialização

```
$ docker run --name postgres -v /path/to/directory/with/sql:/docker-entrypoint-initdb.d -e POSTGRES_PASSWORD=mysecretpasswrd -p 5432:5432 -d postgres:9.4
```

Onde `/path/to/directory/with/sql` é um caminho absoluto, mas pode ser utizado um caminho relativo, conforme abaixo

```
$ docker run --name postgres -v ${PWD}/directory/with/sql:/docker-entrypoint-initdb.d -e POSTGRES_PASSWORD=mysecretpasswrd -p 5432:5432 -d postgres:9.4
```
##### MySQL

Baixando e rodando a imagem do MySQL

1. Primeiramente é preciso baixar a imagem do MySQl

```
$ docker pull mysql
```
2. Iniciar um container contendo a imagem do MySQL expondo na porta 3306

```
$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=<secret> -p 3306:3306 -d mysql
```

3. Acessar o container e acessar o client do MySQL

```
$ docker exec -it mysql bash
$ mysql -p
```

4. Configurar o MySQL para poder ser acessado externamente

```
$ RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
```

Pronto agora você está pronto para utilizar o MySQL

#### Avançados

- [Criação de imagem](https://github.com/Juroviol/Docker/tree/master/eletron-databases)
