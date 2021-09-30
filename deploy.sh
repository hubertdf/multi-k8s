docker build -t hubertdf/multi-client-k8s:latest -t hubertdf/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t hubertdf/multi-server-k8s-pgfix:latest -t hubertdf/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t hubertdf/multi-worker-k8s:latest -t hubertdf/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push hubertdf/multi-client-k8s:latest
docker push hubertdf/multi-server-k8s-pgfix:latest
docker push hubertdf/multi-worker-k8s:latest

docker push hubertdf/multi-client-k8s:$SHA
docker push hubertdf/multi-server-k8s-pgfix:$SHA
docker push hubertdf/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hubertdf/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=hubertdf/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=hubertdf/multi-worker-k8s:$SHA