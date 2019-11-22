kubectl config use-context docker-for-desktop
helm init
kubectl -n kube-system get service.deployment,pod --selector app=helm
helm version
helm init --upgrade
export TILLER_TAG=2.9.0
kubectl --namespace=kube-system set image deployments/tiller-deploy \
	tiller=gcr.io/kubernetes-helm/tiller:$TILLER_TAG

helm repo add incubator https://kubernetes-charts-incubator.storage.googleapi.com/
helm search
helm install -f redmine.yaml --name redmine stable/redmine --version 4.0.0
helm ls
kubectl get service,deployment --selector release=redmine
helm upgrade -f redmine.yaml redmine stable/redmine --version 4.0.0
helm delete redmine
helm ls --all
helm rollback redmine 2
helm el --purge redmin
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-cluster-rule \
	--clusterrole=cluster-admin --serviceaccount=kube-sytem:tiller
kubectl patch deploy --namespace kube-system tiller-deploy \
	-p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

helm install -f jenkins.yaml --name jenkins stable/jenkins
kubectl describe sa,clusterrolebinding -l app=jenkins-jenkins
helm repo list
helm serve &
helm create echo
tree .

helm package echo
helm search echo
helm install -f echo.yaml --name echo local/echo
kubectl get deployment,service,ingress --selector app=echo
curl http://localhost -H 'Host: ch06=echo.takagotch.local'
git clone git@github.com:takagotch/charts.git
cd charts
mkdir stable
helm create example
helm package example
helm repo index .
tree .
git add -A
git commit -m "add first chart"
git push origin gh-pages
curl -s https://takagotch.github.com/charts/stable/index.yaml

helm repo add takagotch-stable https://takagotch.github.io/charts/stable
helm repo update
helm search example
helm install --namespace default --name example takagotch-stable/example

kubectl logs -f update-checker
kubectl patch deployment echo-version \
	-p '' deployment "" patched
kubectl get pod -l app=echo-version -w

kubectl describe pod -l app=echo-version
kubectl get pod -l app=echo-version
kubectl get pod -l app=echo-version
kubectl logs -f update-checker
kubectl apply -f echo-version-1.yaml
kubectl apply -f echo-version-2.yaml
kubectl apply -f update-checker
kubectl patch service echo-version -p '{"spec": {"selector": {"color": "green"}}}'


