## Índice

* [Sonarqube](#sonarqube)
* [Associado ao projeto jenkins](#associado-ao-projeto-jenkins)
* [Criar o secret para ser usada no jenkins](#criar-o-secret-para-ser-usada-no-jenkins)

[Voltar](../../README.md)

# Sonarqube <a name="sonarqube"></a>

Acesse o link: [sonar.local](http://sonar.local). Na primeira instalação, o login e senha são `admin`.

![sonar-01](sonar-01.png)

![sonar-02](sonar-02.png)

![sonar-03](sonar-03.png)

## Associado ao projeto jenkins <a name="associado-ao-projeto-jenkins"></a>

Para retonar o resultado para o jenkins, configurar o Webhooks lá no sonarQube: [sonar.local/admin/webhooks](http://sonar.local/admin/webhooks).

![sonar-04](sonar-04.png)

Adicionar:

- **Name**: `jenkins-sonar`
- **URL**: `https://jenkins:8443/sonarqube-webhook/`

![sonar-05](sonar-05.png)

![sonar-06](sonar-06.png)

### Observação

Se o webhook não funcionar, ve a [documentação do jenkins](../jenkins/README.md), no passo "Webhook não funcionou".

## Criar o secret para ser usada no jenkins <a name="criar-o-secret-para-ser-usada-no-jenkins"></a>

Para o jenkins ter acesso ao sonar, precisamos criar um usuário e criar uma secret.

![sonar-07](sonar-07.png)

Criar um novo usuário para o jenkins.

- **Login**: jenkins-sonar
- **Name**: jenkins-sonar
- **Password**: jenkins123

![sonar-08](sonar-08.png)

Agora precisamos criar um token para ele, e adicionar lá no jenkins. [Ver documentação do jenkins](../jenkins/README.md).

![sonar-09](sonar-09.png)

Criar o token e usar no jenkins.

- **Name**: jenkins-local-token
- **Expires in**: 1 year

![sonar-10](sonar-10.png)
---
[Voltar](../../README.md)
