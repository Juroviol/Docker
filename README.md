# Docker

- [Introdução](#introdução)

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
- [Docker Compose](#)

<br/>

## Introdução

Antigamente quando não existia Docker e queríamos testar uma aplicação desenvolvida na nossa máquina, teríamos que instalar a base de dados e outras dependências necessárias. É claro que isso funciona, e funciona atualmente e provavelmente muitas pessoas ainda fazem assim. O problema é que a aplicação fica altamente vinculada ao ambiente instalado, que no caso é o seu computador. Desta forma não pode ser compartilhada, bagunça a seu computador com instalações e claramente não é um ambiente reproduzível. Lembra da história na minha máquina funciona? Então, isso acaba com o Docker.

Eis algumas perguntas pertinentes que nos ajudam a entender o que o Docker soluciona:

1. E se você está trabalhando em dois projetos que utilizam diferentes versões da sua base de dados favorita?
2. E se você está trabalhando com diferentes linguagens de programação? Você as mantém com suas respectivas dependências instaladas e mantidas no seu computador? Em versões diferentes?
3. E se você quisesse compartilhar o que você desenvolveu com os seus colegas? Quão frequentemente seus computadores possuem configurações totalmente diferentes? Será que rodará?
3. Quantos processos rodando em plano de fundo 24/7 para rodar e testar seu software?
4. E se você possui além do seu ambiente local, diversos outros ambientes como: ambiente de desenvolvimento, homologação e produção? Fará todo o processo de instalação das dependências que sua aplicação utiliza em todos os ambientes? E se eu precisar criar diversos ambientes de homologação para testar funcionalidades independentes?

O Docker nos ajuda com todas estas questões e muito mais. O Docker é uma plataforma de código aberto para criar, executar e gerenciar conteineres.

Os containers funcionam um pouco como as máquinas virtuais (VMs), mas de uma maneira muito mais específica e granular. Em uma máquina virtual, é possível utilizar diversos recursos e ferramentas rodando. Porém tudo roda em um mesmo sistema operacional. Em caso de pane tudo é afetado.

No caso dos containers, a ideia é que cada um faça apenas um serviço e assuma uma só responsabilidade. Pegando a ideia da aplicação e o seu banco de dados, poderíamos ter: um container rodando uma aplicação e outro container rodando a base de dados.

Os containeres são criados a partir de imagens Docker. Uma imagem Docker é um arquivo de template que contém diversas instruções para se criar um container. Neste arquivo nós encontramos diversas instruções que serão executadas no Docker instalado na máquina do hospedeiro para disponibilizar algum serviço. Um exemplo prático de imagem Docker conteria instruções para se disponibilizar um banco de dados rodando numa porta X.

<br/>

## Comandos básicos

### Baixar uma imagem

```
$ docker pull <image-name>
```

### Listar imagens baixadas

```
$ docker image ls
```

### Iniciar um container a partir de uma imagem

```
$ docker run --name <container-name> -d <image-name>
```

Onde `container-name` é o nome que será dado ao container, e `image-name` é o nome da imagem a partir do qual o container será iniciado.

### Listar os containeres criados

```
$ docker container ls --all
```

### Iniciar um container parado

```
$ docker container start <name>
```

### Parar um container

```
$ docker container stop <name>
```

### Remover um container

```
$ docker rm <name>
```

### Remover uma imagem

```
$ docker image rmi <image_id>
```

### Iniciar uma sessão bash no container para rodar comandos bash dentro do container

```
$ docker exec -it <container> bash
```

### Construir uma imagem a partir do Dockerfile

```
$ docker build <directory> -t <name>
```

Onde `directory` é o diretório onde está o Dockerfile e `name` o nome da imagem que será criada.

### Salvar uma imagem criada em um arquivo .tar

```
$ docker save --output <tar-name> <image-name>
```

Onde `tar-name` é o nome do arquivo tar salvado e `image-name` o nome da imagem que será salvada como .tar.

### Carregar uma imagem a partir de um arquivo .tar

```
$ docker load --input <tar-name>
```

Onde `tar-name` é o nome do arquivo .tar 

<br/>

### Taguear uma imagem Docker

```
$ docker tag <image_id>  <account_name>/<image_name>:<tag>
```

Onde `image_id` é id da imagem, `account_name` é o nome da conta no Docker Hub e `image_name` é o nome da imagem. 

### Publicar uma imagem no Docker Hub

```
$ docker push <username>/<tag>
```

## Exemplos de utilização

### Básicos

#### PostgreSQL

Baixando e rodando a imagem do Postgres

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

<br/>

## Docker Compose

Conforme vimos acima, uma vez instalado o Docker em uma máquina, podemos executar os comandos mencionados para se iniciar um container que envolve: executar o comando para realizar o donwload da imagem e em seguida executar o comando para se iniciar o container passando algumas configurações. Isto funciona perfeitamente. Mas e se, por exemplo, quisermos rodar uma aplicação desenvolvida em um container e em outro container rodar um banco de dados. Teríamos que fazer o mesmo processo para os dois containeres, correto? Mas e se tivermos uma necessidade que demande de 5 serviços, ou até mais, estarem rodando ao mesmo tempo cada um seu respectivo container e com suas dependências? Faríamos este processo para cada container? E se tivermos que fazer isso em 3 ambientes diferentes? Se tornaria um processo muito trabalhoso sem falar que poderíamos cometer algum erro na configuração de inicialização de algum container.

Para resolver este problema existe o Docker Compose. Docker Compose é uma ferramenta que foi desenvolvida para ajudar a definir e compartilhar aplicações multi-conteineres. Com o Compose, nós podemos criar um arquivo YAML e definir os serviços que serão necessários e com um único comando podemos levantar tudo ou derrubar tudo. No problema exercitado acima, definiriamos os 5 serviços ou mais num único arquivo YAML e o Docker Compose realizaria todos aqueles comandos manuais que precisaríamos executar de uma única vez.
