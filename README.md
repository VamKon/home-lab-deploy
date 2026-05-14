# home-lab-deploy

ArgoCD App of Apps for a k3s homelab cluster.

## Repository layout

```
bootstrap/                  # Apply once to seed ArgoCD
  argocd-app-of-apps.yaml

apps/                       # ArgoCD watches this directory (App of Apps)
  cert-manager.yaml
  ingress-nginx.yaml
  metallb.yaml
  longhorn.yaml
  kube-prometheus-stack.yaml

addons/                     # Helm wrapper chart per add-on
  cert-manager/
  ingress-nginx/
  metallb/
  longhorn/
  kube-prometheus-stack/
```

## Bootstrap

### 1. Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Apply the root Application

```bash
kubectl apply -f bootstrap/argocd-app-of-apps.yaml
```

ArgoCD will now discover every Application manifest under `apps/` and reconcile them automatically.

## Add-ons included

| Add-on | Namespace | Notes |
|---|---|---|
| cert-manager | cert-manager | Deploys a `selfsigned` ClusterIssuer by default |
| ingress-nginx | ingress-nginx | Uses `LoadBalancer` service type (requires metallb) |
| metallb | metallb-system | Edit `addons/metallb/templates/ip-address-pool.yaml` with your LAN IP range |
| longhorn | longhorn-system | Requires `open-iscsi` on each node — see values.yaml |
| kube-prometheus-stack | monitoring | Prometheus + Grafana + Alertmanager |

## Customisation

- **MetalLB IP pool** — update `addons/metallb/templates/ip-address-pool.yaml` with an unused range on your LAN.
- **Grafana password** — replace `changeme` in `addons/kube-prometheus-stack/values.yaml` or inject a Kubernetes Secret.
- **Let's Encrypt** — uncomment the `letsencrypt-prod` ClusterIssuer in `addons/cert-manager/templates/cluster-issuer.yaml`.
- **Longhorn replicas** — set `defaultReplicaCount: 1` for a single-node cluster.
- **Disable an add-on** — delete or comment out the corresponding file in `apps/`.

## Disabling k3s built-ins

If you want nginx-ingress to be the sole ingress controller, disable Traefik when installing k3s:

```bash
curl -sfL https://get.k3s.io | sh -s - --disable traefik
```
