### Prerequisits
- Docker Engine v19.03.2

### Install tools:
1. install virtualbox (MacOS): `brew cask install virtualbox`
2. install kubectl: `brew install kubectl`
3. install minikube: `brew cask install minikube`
4. start minikube: `minikube start`

### Create Docker image
1. Add web page script `server.js`
2. Add `Dockerfile` 
3. Configure docker env `eval $(minikube docker-env)`
4. Build image `docker build -t hello:1.0 .`

### Create configuration files:
- deployment YMLs `dev-deployment.yml`, `ops-deployment.yml`
- name based ingress YML `ingress.yml`

### Putting it all together
1. Create pods using deployments:
    - `kubectl apply -f dev-deployment.yml`
    - `kubectl apply -f ops-deployment.yml`
    Check created deployments:
    `kubectl get deployment`
    ```bash
    NAME        READY   UP-TO-DATE   AVAILABLE   AGE
    hello-dev   1/1     1            1           15m
    hello-ops   1/1     1            1           15m
    ```
    
    Check pods:
    `kubectl get pods`
    ```bash
    NAME                         READY   STATUS    RESTARTS   AGE
    hello-dev-699994bfb9-vmk2v   1/1     Running   0          16m
    hello-ops-6d9bcb9f7b-kmmqj   1/1     Running   0          16m
    ```

2. Expose pods as services to make them accessible from outside the Kubernetes internal network
    - `kubectl expose -f dev-deployment.yml`
    - `kubectl expose -f ops-deployment.yml`
    
    Check services:
    `kubectl get services`
    
    ```bash
    NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
    hello-dev    ClusterIP   10.106.88.15    <none>        8080/TCP         4m41s
    hello-ops    NodePort    10.105.249.17   <none>        8080:30770/TCP   15m
    kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          21h
    ```
3. Create Ingress `kubect apply -f ingress.yml`
    Check ingress:
    `kubectl get ingress`
    ```bash
    NAME            HOSTS                           ADDRESS     PORTS   AGE
    hello-ingress   dev.hello.info,ops.hello.info   10.0.2.15   80      16m
    ```
    `kubectl describe ingress hello-ingress`
    
    ```bash
    Name:             hello-ingress
    Namespace:        default
    Address:          10.0.2.15
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host            Path  Backends
      ----            ----  --------
      dev.hello.info
                         hello-dev:8080 (172.17.0.8:8080)
      ops.hello.info
                         hello-ops:8080 (172.17.0.6:8080)
    Annotations:
      kubectl.kubernetes.io/last-applied-configuration:  {"apiVersion":"networking.k8s.io/v1beta1","kind":"Ingress","metadata":{"annotations":{},"name":"hello-ingress","namespace":"default"},"spec":{"rules":[{"host":"dev.hello.info","http":{"paths":[{"backend":{"serviceName":"hello-dev","servicePort":8080}}]}},{"host":"ops.hello.info","http":{"paths":[{"backend":{"serviceName":"hello-ops","servicePort":8080}}]}}]}}
    
    Events:
      Type    Reason  Age   From                      Message
      ----    ------  ----  ----                      -------
      Normal  CREATE  16m   nginx-ingress-controller  Ingress default/hello-ingress
      Normal  UPDATE  16m   nginx-ingress-controller  Ingress default/hello-ingress
    ```
4. Get minikube IP:
    `minikube ip` 
    for me it is `192.168.99.100`

5. Add new domains to `/etc/hosts`
    ```bash
    192.168.99.100 hello-world.info ops.hello.info dev.hello.info
    ```
6. Check all this stuff in action:

- Command: `curl dev.hello.info` result
    ```bash
    Hello, Dev!
    ```
- Command `curl ops.hello.info` result
    ```bash
    Hello, Ops!
    ```

