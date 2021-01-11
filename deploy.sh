docker build -t thirteen/multi-client:latest -t thirteen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thirteen/multi-server:latest -t thirteen/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t thirteen/multi-worker:latest -t thirteen/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push thirteen/multi-client:latest
docker push thirteen/multi-server:latest
docker push thirteen/multi-worker:latest
docker push thirteen/multi-client:$SHA
docker push thirteen/multi-server:$SHA
docker push thirteen/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thirteen/multi-server:$SHA
kubectl set image deployments/client-deployment client=thirteen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thirteen/multi-worker:$SHA