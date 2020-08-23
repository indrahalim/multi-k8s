docker build -t indrahalim/multi-client:latest -t indrahalim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t indrahalim/multi-server:latest -t indrahalim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t indrahalim/multi-worker:latest -t indrahalim/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push indrahalim/multi-client:latest
docker push indrahalim/multi-server:latest
docker push indrahalim/multi-worker:latest

docker push indrahalim/multi-client:$SHA
docker push indrahalim/multi-server:$SHA
docker push indrahalim/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=indrahalim/multi-server:$SHA
kubectl set image deployments/client-deployment client=indrahalim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=indrahalim/multi-worker:$SHA