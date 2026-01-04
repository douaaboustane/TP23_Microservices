# 📦 Installation et Démarrage de Consul

## ⚠️ Problème : Consul n'est pas installé

Vous avez deux options :

---

## 🐳 Option 1 : Utiliser Docker (RECOMMANDÉ - Plus Simple)

### Avantages :
- ✅ Pas besoin d'installer Consul manuellement
- ✅ Fonctionne immédiatement
- ✅ Facile à démarrer/arrêter

### Démarrer Consul avec Docker :

```bash
docker run -d --name consul -p 8500:8500 -p 8600:8600/udp consul:1.17 agent -dev -client=0.0.0.0
```

### Vérifier que Consul tourne :

```bash
docker ps
```

### Accéder à l'interface Web :

Ouvrir : **http://localhost:8500**

### Arrêter Consul :

```bash
docker stop consul
docker rm consul
```

### OU utiliser Docker Compose (encore plus simple) :

```bash
docker-compose up consul
```

Cela démarrera Consul avec toute la configuration nécessaire.

---

## 📥 Option 2 : Installer Consul Manuellement

### Étape 1 : Télécharger Consul

1. Aller sur : https://www.consul.io/downloads
2. Télécharger la version Windows (64-bit)
3. Exemple : `consul_1.17.0_windows_amd64.zip`

### Étape 2 : Extraire l'archive

1. Extraire le fichier `consul.exe` dans un dossier (exemple : `C:\Consul`)

### Étape 3 : Ajouter au PATH

**Méthode 1 : Via l'interface Windows**
1. Appuyer sur `Win + R`
2. Taper `sysdm.cpl` et appuyer sur Entrée
3. Aller dans l'onglet "Avancé"
4. Cliquer sur "Variables d'environnement"
5. Dans "Variables système", trouver "Path" et cliquer sur "Modifier"
6. Cliquer sur "Nouveau" et ajouter le chemin (exemple : `C:\Consul`)
7. Cliquer sur "OK" partout

**Méthode 2 : Via PowerShell (en tant qu'administrateur)**
```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Consul", "Machine")
```

### Étape 4 : Vérifier l'installation

1. **Fermer et rouvrir** le terminal (important !)
2. Taper :
```bash
consul version
```

Si cela fonctionne, vous verrez la version de Consul.

### Étape 5 : Démarrer Consul

```bash
consul.exe agent -dev
```

---

## 🚀 Solution Rapide : Utiliser Docker Compose

Le projet contient déjà un `docker-compose.yml` qui configure tout automatiquement.

### Démarrer Consul seul :

```bash
docker-compose up consul
```

### Démarrer tout (Consul + Services) :

```bash
docker-compose up --build
```

---

## ✅ Vérification

Une fois Consul démarré (peu importe la méthode), vérifier :

1. **Interface Web** : http://localhost:8500
2. **Via ligne de commande** :
   ```bash
   curl http://localhost:8500/v1/status/leader
   ```

---

## 💡 Recommandation

Pour ce TP, **utilisez Docker** car :
- ✅ Plus rapide à mettre en place
- ✅ Pas besoin de configuration PATH
- ✅ Fonctionne immédiatement
- ✅ Facile à nettoyer après

---

## 🔧 Commandes Docker Utiles

```bash
# Voir les logs de Consul
docker logs consul

# Voir les logs en temps réel
docker logs -f consul

# Redémarrer Consul
docker restart consul

# Arrêter et supprimer Consul
docker stop consul
docker rm consul
```

