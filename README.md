# Usuage
To deploy bcc container into your OpenShift Cluster, do the following:

Create a new project:
```
oc new-project bcc
oc project bcc
```

Deploy ebpf pod your container, the pod config has escalated privileges
```
oc create -f bcc-pod.yaml
oc get po
```

Copy kernel-headers, kernel-devel packages to match the running host kernel
```
oc cp /Users/krvoora/Desktop/kernel-devel.rpm bcc/bcc:/tmp/
oc cp /Users/krvoora/Desktop/kernel-headers.rpm bcc/bcc:/tmp/
```

Force install *.rpms
```
oc exec -it bcc bash
cd /tmp/
rpm -ivh --nodeps --force kernel-devel.rpm
rpm -ivh --nodeps --force kernel-headers.rpm
```

Neccessary evil, since we are running this inside a container
Thanks to Michey Mehta's pointers on this
```
mkdir -p /lib/modules/$(uname -r)
ln -s /usr/src/kernels/$(uname -r) /lib/modules/$(uname -r)/build
```