## Índice

* [Primeiro login](#primeiro-login)
* [Criando usuário para integração com o jenkins](#criando-usuário-para-integração-com-o-jenkins)
* [Criar um docker repo](#criar-um-docker-repo)

[Voltar](../../README.md)

# Nexus

O nexus iremos guardar nossas imagens e artefatos. Para acessar: [nexus.local](https://nexus.local).

## Primeiro login <a name="primeiro-login"></a>

Por padrão, o usuário é `admin` e senha é `admin123` no login inicial, podendo ser modificado a qualquer momento.

![Nexus login](nexus-01.png)
![Nexus wizard](nexus-02.png)

Aqui é de sua escolha.

![Nexus Anonymous access](nexus-03.png)

Finalizado.

![Nexus complete](nexus-04.png)

## Criando usuário para integração com o jenkins <a name="criando-usuário-para-integração-com-o-jenkins"></a>

Para a integração com o jenkins, criar um usuário login `jenkins` e senha `jenkins123`. É preciso criar no Jenkins, nas credenciais, com ID `jenkins-nexus` e usar o login e senha criados no nexus. Isso está na documentação do [Jenkins](../jenkins/README.md).

![Nexus usuário jenkins](nexus-user-01.png)

Preencher os dados.

![Nexus usuário jenkins](nexus-user-02.png)

Preencher conforme os dados para ser utilziado no jenkins.

![Nexus usuário jenkins](nexus-user-03.png)

Usuário criado.

![Nexus usuário jenkins](nexus-user-04.png)

## Criar um docker repo <a name="criar-um-docker-repo"></a>

Criar um repositório para as imagens docker (registry docker). Será usado pelo `jenkins` e pelo `kubernate`. Todas as imagens criadas serão guardadas no nexus e usadas no `kubernate` par ao deploy das aplicações.

- Repositories
  - docker (hosted)
    - nome: `docker-repo`
    - HTTPS: `8123` | Exposto lá no docker compose

![Nexus repositories](nexus-repositories-01.png)

Criar um hosted para as imagens do docker.

![Nexus repositories](nexus-repositories-02.png)

Adicionando os dados do repositório (registry para o k3s).

![Nexus repositories](nexus-repositories-03.png)

Repositório criado.

![Nexus repositories](nexus-repositories-04.png)

---
[Voltar](../../README.md)