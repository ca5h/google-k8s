docker build -t akashinnf/multi-client:latest -t akashinnf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akashinnf/multi-server:latest -t akashinnf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akashinnf/multi-worker:latest -t akashinnf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akashinnf/multi-client:latest
docker push akashinnf/multi-server:latest
docker push akashinnf/multi-worker:latest

docker push akashinnf/multi-client:$SHA
docker push akashinnf/multi-server:$SHA
docker push akashinnf/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akashinnf/multi-server:$SHA
kubectl set image deployments/client-deployment client=akashinnf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akashinnf/multi-worker:$SHA