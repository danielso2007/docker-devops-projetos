## Índice

* [Jenkins](#jenkins)
* [Criar usuário para acesso ao sonar](#criar-usuário-para-acesso-ao-sonar)
* [Configurando o Sonar Scanner](#configurando-o-sonar-scanner)
* [Configurar o tools](#configurar-o-tools)
* [Obter o retorno do sonar via webhook](#obter-o-retorno-do-sonar-via-webhook)
* [Acessando o registry docker e images do nexus](#acessando-o-registry-docker-e-images-do-nexus)
* [Criando um pipeline](#criando-um-pipeline)
  * [Criando o repositório privado](#criando-o-repositório-privado)
  * [Criar o pipeline do projeto](#criar-o-pipeline-do-projeto)
  * [Iniciar o build](#iniciar-o-build)
* [Webhook não funcionou](#webhook-não-funcionou)

[Voltar](../../README.md)

# Jenkins <a name="jenkins"></a>

O Jenkins é uma ferramenta de automação open-source amplamente utilizada para implementar práticas de Integração Contínua (CI) e Entrega Contínua (CD). Ele permite automatizar tarefas repetitivas no desenvolvimento de software, como compilação, testes, implantação e muito mais.

Inicialmente é gerada uma senha aleatório. Acesse `docker compose logs jenkins` para ver no console a senha. Também podemos obter a senha por `docker compose exec -it jenkins cat /var/lib/jenkins/secrets/initialAdminPassword`.

![Senha jenkins](jenkins-01.png)

Para acessar: [jenkins.local](http://jenkins.local). No `Dockerfile` já é incluído vários plugin, você poderá ajustar a qualquer momento.

![Login jenkins](jenkins-02.png)

![Login jenkins](jenkins-03.png)

![Login jenkins](jenkins-04.png)

![Login jenkins](jenkins-05.png)

![Login jenkins](jenkins-06.png)

![Login jenkins](jenkins-07.png)

Só realizar o login.

![Login jenkins](jenkins-08.png)

Tela inicial.

![Login jenkins](jenkins-09.png)

## Criar usuário para acesso ao sonar <a name="criar-usuário-para-acesso-ao-sonar"></a>

Lá no [sonarqube](../sonar/README.md), precisamos criar um usuário para o Jenkins. Para esse usuário, é preciso adicionar a secret nas credenciais do jenkins. Acesse [Global credentials (unrestricted)](https://jenkins.local/manage/credentials/store/system/domain/_/).

- Secret: `CRIADO NO SONAR`
- ID: `secret-sonar`
- Description: `secret-sonar`

![secret jenkins](jenkins-10.png)

![secret jenkins](jenkins-11.png)

![secret jenkins](jenkins-12.png)

## Configurando o Sonar Scanner <a name="configurando-o-sonar-scanner"></a>

Acesse as configurações do Jenkins: [System](http://jenkins.local/manage/configure). É preciso criar um usuário para o jenkins no sonar e obter a `secret`. O [item acima](#criar-usuário-para-acesso-ao-sonar) é criado esse usuário.

Ir até o título `SonarQube servers`:
- `Environment variables` = check true
- Add SonarQube
- Name: `sonar-server`
- Server URL: `http:sonarqube:9000`
- Add Server authentication token, [credencial criada aqui](#criar-usuário-para-acesso-ao-sonar)

![secret jenkins](jenkins-13.png)

![secret jenkins](jenkins-14.png)

## Configurar o tools <a name="configurar-o-tools"></a>

Ir em [jenkins.local/manage/configureTools](http://jenkins.local/manage/configureTools/). Acessar: `SonarQube Scanner instalações`.

Ir até o título `SonarQube Scanner instalações`:
- Name: `sonar-scanner`
- Instalar a versão automaticamente

![secret jenkins](jenkins-15.png)

![secret jenkins](jenkins-16.png)

## Obter o retorno do sonar via webhook <a name="obter-o-retorno-do-sonar-via-webhook"></a>

Para receber o ok do sonar ver a [documentação aqui](../sonar/README.md).

## Acessando o registry docker e images do nexus <a name="acessando-o-registry-docker-e-images-do-nexus"></a>

Para ter acesso ao nexus e gravar as imagens criadas. Criar uma variável global em [https://jenkins.local/manage/configure](https://jenkins.local/manage/configure) no jenkins:

- `NEXUS_URL=localhost:8123`

**Observação**: Só foi possível acessar o repositório de imagens abrindo a porta `8123` no docker compose, por isso usamos `localhost:8123`.

![secret jenkins](jenkins-17.png)

![secret jenkins](jenkins-18.png)

É preciso criar um usuário no jenkins para acessar o nexus. Em `https://jenkins.local/manage/credentials/store/system/domain/_/`, criado no item "Criando usuário para integração com o jenkins":

- Username: `jenkins`
- Password: `jenkins123`
- ID: `jenkins-nexus`

![secret jenkins](jenkins-19.png)

![secret jenkins](jenkins-20.png)

![secret jenkins](jenkins-21.png)

Essas configurações serão usadas pelo pipeline criado no projeto [aqui](../../../sonarqube-lab/README.md).

## Criando um pipeline <a name="criando-um-pipeline"></a>

As configurações acima levam em consideração o uso de um projeto. Esse está no projeto `sonarqube-lab` e se chama `redis-app`. Para continuar com o projeto, crie um repositório privado e credenciais de acesso para o jenkins.

### Criando o repositório privado <a name="criando-o-repositório-privado"></a>

Crie um repositório privado do projeto mencionado anteriormente, conforme imagens abaixo. Esse projeto já existe um `jenkinsfile` configurado.

![secret jenkins](jenkins-22.png)

É preciso criar as credenciais para acesso a esse projeto.

![secret jenkins](jenkins-23.png)

![secret jenkins](jenkins-24.png)

Esses dados serão usados no pipeline:

- **User:** jenkins-casa-docker
- **secret:** ghp_UeffBZQ1Jxxx8aI8fkWWgAamxxxxx9
- **GIT:** https://github.com/danielso2007/redis-app

### Criar o pipeline do projeto <a name="criar-o-pipeline-do-projeto"></a>

Agora vamos criar o pipeline para build e upalod de imagens no nexus.


![secret jenkins](jenkins-25.png)

Criar novo pipeline:

![secret jenkins](jenkins-26.png)

Criar uma nova credencial:

![secret jenkins](jenkins-27.png)

![secret jenkins](jenkins-28.png)

![secret jenkins](jenkins-29.png)

### Iniciar o build <a name="iniciar-o-build"></a>

Só criar o build do projeto.

![secret jenkins](jenkins-30.png)

Tudo dando certo, o build é com sucesso.

![secret jenkins](jenkins-31.png)

A imagem foi criada no nexus.

![secret jenkins](jenkins-32.png)

## Webhook não funcionou <a name="webhook-não-funcionou"></a>

Se o webhook não funcionar condfigurado na documentação do sonar, adicioe o webhook no [projeto do sonar](../sonar/README.md), conforme imagens abaixo:

![secret jenkins](jenkins-webhook-01.png)

![secret jenkins](jenkins-webhook-02.png)

---
[Voltar](../../README.md)