## Índice

* [Start do projeto](#start-do-projeto)
* [Iniciando](#iniciando)
* [Reiniciando o k3s-local](#reiniciando-o-k3s-local)
* [Acessando o Rancher](#acessando-o-rancher)
* [Confirmação da subida do k3s-local como node do Rancher](#confirmação-da-subida-do-k3s-local-como-node-do-rancher)

[Voltar](../../README.md)

# K3s - Kubernete

Documentação: [docs.k3s.io/quick-start](https://docs.k3s.io/quick-start).

Caso desejar acessando o container:
```shell
docker compose exec k3s sh
```

Listar todos os Pods:

```shell
kubectl get pods --all-namespaces
```

## Caso precise examinar o Pod criado

Em alguns caso, pode dar erro e você precise analisar, então abaixo alguns comandos úteis:

Ver todos os pods:
```shell
kubectl get pods --all-namespaces
```

Ver os logs do pod:
```shell
kubectl logs <NOME-DO-POD> -n <NAME-SPACE>
```

## Deletando o pod criado

Se precisar deletar o pod que foi criado o cluster no rancher, execute o comando baixo:
```shell
kubectl delete -f cluster.yaml 
```

# Registries para o K3s

Está está definido no volume `./k3s/registries/registries.yaml`, apontando para o nosso nexus. Caso você mude de nexus, só configurar esse arquivos.