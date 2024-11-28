## Índice

* [Start do projeto](#start-do-projeto)
* [Iniciando](#iniciando)
* [Reiniciando o k3s-local](#reiniciando-o-k3s-local)
* [Acessando o Rancher](#acessando-o-rancher)
* [Confirmação da subida do k3s-local como node do Rancher](#confirmação-da-subida-do-k3s-local-como-node-do-rancher)

[Voltar](../../README.md)

# Rancher

Temos um container `rancher` apenas para estudo, pois já instalamos um kubernate `K3s` anteriormente. 

Para acessar o Rancher, obter a senha com o comando abaixo (no final da execução do `start.sh` é aberto o browser automaticamente):

```shell
docker compose logs rancher 2>&1 | grep "Bootstrap Password:"

$ rancher-local  | 2024/10/26 21:14:03 [INFO] Bootstrap Password: xxxxxxxx # Automaticamente o shell start.sh abre o rancher
```

Agora acesse [https://rancher.local/dashboard/?setup=xxxxxxxx](https://rancher.local/dashboard/?setup=xxxxxxxx).


# Incluindo um novo node no rancher do nosso container k3s

Depois da primeira execução, é preciso executar o sh `novo-k3s-refazer-token.sh`. Ao executar, o container `k3s` é removido, logo após, é obtido o token no container `rancher` e incluído automaticamente no `K3S_TOKEN` do `docker-compose.yml`. Após isso, um novo node será incluídos no `rancher` no cluster `local`.

### Token para um novo node:

Caso queira obter manualmente:

Execute: `docker compose exec rancher cat /var/lib/rancher/k3s/server/node-token`.

# Novo cluster no rancher

No item anterior, colocamos um agente (node) no rancher. Agora estamos adicionando um cluster no rancher, para isso, foi criado um container `k3s-cluster` configurado para ser um kubernate normal. Para adicionado, seguir os passos abaixo:

- Primeiro precisamos opter o IP do rancher:
    - `docker inspect rancher-local -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'`
- Acesse o rancher na parte `Global Settings` e `Settings`:
    - No campo `server-url`, troque de `https://rancher.local/` para `https://<IP_RANCHER>`;
    - **Observação**: isso é porque estamos com estudo e dentro de docker em produção não será assim;
    - Sempre olhe esse campo para futuras modificações.
- Vá para a `home`, clicar em `Import Existing`;
- Escolha `Import any Kubernetes cluster > Generic`;
- Adicione um nome ao cluster: `k3s-cluster`;
- Clique em `create`;
- Será exibido vários ações, neste momento:
    - Copie o endereço do `yaml` apenas, exemplo: `https://rancher.local/v3/import/5ljwpnfr4gnq9jxhrs5tsns4km6h7cbf5dfzgqwx4gpct7v4xwvbqc_c-m-zphfb8s2.yaml`;
    - Copie o conteúdo e adicione no arquivo `./k3s/yaml/cluster.yaml`;
    - Esse arquivo está como volume do nosso container `k3s-cluster`.
- Agora acesse via `exec -it` (ou outro modo) o container `k3s-cluster`;
- Acesse a paster `/opt/yaml`;
- Excecute `kubectl apply -f cluster.yaml` para adicionar o cluster ao rancher;
- Se tudo der certo, será criado um novo cluster no rancher.