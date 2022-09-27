compartment-name = "kubernetes-always-free"
compartment-description = "Compartment to hold all resources required for the always free kubernetes project"
pub-security-list-rules = {
    "rules" = {
        "egress_rules" = {
            "Kubernetes-API-Server" = {
                destination = "10.0.0.0/16"
                max-port = 6443
                min-port = 6443
            }
            "etcd" = {
                destination = "10.0.0.0/24"
                max-port = 2380
                min-port = 2379
            }
            "Kube-Scheduler-Service" = {
                destination = "10.0.0.0/16"
                max-port = 10259
                min-port = 10259
            }
            "Kube-Controller-Manager" = {
                destination = "10.0.0.0/16"
                max-port = 10257
                min-port = 10257
            }
            "Kubelet" = {
                destination = "10.0.0.0/16"
                max-port = 10250
                min-port = 10250
            }
            "NodePort-Services" = {
                destination = "10.0.0.0/16"
                max-port = 32767
                min-port = 30000
            }
        }
        "ingress_rules" = {
            "Kubernetes-api-server" = {
                source = "10.0.0.0/16"
                max-port = 6443
                min-port = 6443
            }
            "etcd" = {
                source = "10.0.0.0/24"
                max-port = 2380
                min-port = 2379
            }
            "Kube-Scheduler-Service" = {
                source = "10.0.0.0/16"
                max-port = 10259
                min-port = 10259
            }
            "Kube-Controller-Manager" = {
                source = "10.0.0.0/16"
                max-port = 10257
                min-port = 10257
            }
            "Kubelet" = {
                source = "10.0.0.0/16"
                max-port = 10250
                min-port = 10250
            }
            "NodePort-Services" = {
                source = "10.0.0.0/16"
                max-port = 32767
                min-port = 30000
            }
            "http" = {
                source = "0.0.0.0/0"
                max-port = 80
                min-port = 80
            }
             "https" = {
             source = "0.0.0.0/0"
                max-port = 443
                min-port = 443
            }
        }
    }
}

priv-security-list-rules = {
    "rules" = {
        "egress_rules" = {
            "Kubernetes-API-Server" = {
                destination = "10.0.0.0/16"
                max-port = 6443
                min-port = 6443
            }
            "etcd" = {
                destination = "10.0.0.0/24"
                max-port = 2380
                min-port = 2379
            }
            "Kube-Scheduler-Service" = {
                destination = "10.0.0.0/16"
                max-port = 10259
                min-port = 10259
            }
            "Kube-Controller-Manager" = {
                destination = "10.0.0.0/16"
                max-port = 10257
                min-port = 10257
            }
            "Kubelet" = {
                destination = "10.0.0.0/16"
                max-port = 10250
                min-port = 10250
            }
            "NodePort-Services" = {
                destination = "10.0.0.0/16"
                max-port = 32767
                min-port = 30000
            }
        }
        "ingress_rules" = {
            "Kubernetes-API-Server" = {
                source = "10.0.0.0/16"
                max-port = 6443
                min-port = 6443
            }
            "etcd" = {
                source = "10.0.0.0/24"
                max-port = 2380
                min-port = 2379
            }
            "Kube-Scheduler-Service" = {
                source = "10.0.0.0/16"
                max-port = 10259
                min-port = 10259
            }
            "Kube-Controller-Manager" = {
                source = "10.0.0.0/16"
                max-port = 10257
                min-port = 10257
            }
            "Kublet" = {
                source = "10.0.0.0/16"
                max-port = 10250
                min-port = 10250
            }
            "NodePort-Services" = {
                source = "10.0.0.0/16"
                max-port = 32767
                min-port = 30000
            }
        }
    }
}

