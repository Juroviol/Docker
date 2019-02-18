# Docker
Exemplos de utilização do Docker

Listar imagens baixadas

```
$ docker image ls
```

Listar os containeres criados

```
$ docker container ls --all
```

Iniciar um container parado

```
$ docker container start <name>
```

Parar um container

```
$ docker container stop <name>
```

Iniciar uma sessão bash no container para rodar comandos bash dentro do container

```
$ docker exec -it <container> bash
```

## MySQL

Baixando e rodando a imagem do MySQL

1. Primeiramente é preciso baixar a imagem do MySQl

```
$ docker pull mysql
```
2. Iniciar um container contendo a imagem do MySQL expondo na porta 3306

```
$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=<secret> -d -p 3306:3306 mysql
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

Pronto agora você está pronto para conectar de qualquer SGBD.
