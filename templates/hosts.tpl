[master]
%{ for ip in master_ips ~}
${ip}
%{ endfor ~}

[node]
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}


[k3s_cluster:children]
master
node