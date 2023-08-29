# IBA-DevOps-Practicum-Diplom2

Создать EKS cluster с двумя нодами t3.small. 
Use data from "Diplom1"

> cat tf_diplom1_data.tf
```
data "terraform_remote_state" "kubernetes_cluster" {
  backend = "s3"
  config = {
    bucket = "ushakou-diplom"
    key    = "diplom1/state.tfstate"
    region = "us-east-1"
  }
}

output "cluster_name" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_name
}

output "cluster_region" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.region
}
```
```
terraform init
terraform apply
aws eks update-kubeconfig --region $(terraform output -raw cluster_region) --name $(terraform output -raw cluster_name)
```

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.8.2/manifests/install.yaml

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath={.data.password} | base64 -d; echo

kubectl port-forward svc/argocd-server -n argocd 8080:443

#kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
#kubectl get all --namespace argocd # and find external ip

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/aws/deploy.yaml

kubectl apply -f ./monitoring_application.yaml
kubectl apply -f ./application.yaml

```
Задеплоить любое веб-приложение в Kubernetes и подключить мониторинг, используя Grafana, Prometheus. 
Веб-приложение должно быть доступно через браузер. 
Деплой приложения должен происходить через CI/CD инструмент. Рекомендуемый инструмент для CICD в Kubernetes – ArgoCD.
 
https://github.com/Admiralissimus/RockPaperScissors
