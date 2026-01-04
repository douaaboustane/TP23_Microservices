# ✅ Consul est maintenant démarré !

## 🎉 Consul fonctionne avec Docker

Consul est maintenant en cours d'exécution dans un conteneur Docker.

### Vérifier que Consul fonctionne :

1. **Interface Web** : Ouvrez votre navigateur et allez sur :
   ```
   http://localhost:8500
   ```

2. **Vérifier via ligne de commande** :
   ```bash
   docker ps | findstr consul
   ```

3. **Voir les logs** :
   ```bash
   docker logs consul
   ```

---

## 📋 Commandes Utiles

### Gérer le conteneur Consul

```bash
# Voir l'état
docker ps | findstr consul

# Voir les logs
docker logs consul

# Voir les logs en temps réel
docker logs -f consul

# Arrêter Consul
docker stop consul

# Redémarrer Consul
docker restart consul

# Supprimer le conteneur (arrête d'abord)
docker stop consul
docker rm consul
```

### Commandes Consul (via Docker)

```bash
# Voir les services enregistrés
docker exec consul consul catalog services

# Voir les détails d'un service
docker exec consul consul catalog service SERVICE-CLIENT

# Voir les nodes
docker exec consul consul members

# Voir les health checks
docker exec consul consul health service SERVICE-CLIENT
```

---

## 🚀 Prochaines Étapes

Maintenant que Consul est démarré :

1. ✅ **Consul est accessible** : http://localhost:8500
2. ⏭️ **Démarrer vos services** :
   ```bash
   # Terminal 1 - Client Service
   cd Client
   mvn spring-boot:run
   
   # Terminal 2 - Gateway Service
   cd Gateway
   mvn spring-boot:run
   ```
3. ⏭️ **Vérifier dans Consul UI** que les services s'enregistrent
4. ⏭️ **Tester les endpoints**

---

## 🔄 Redémarrer Consul

Si vous devez redémarrer Consul :

```bash
docker restart consul
```

Ou supprimer et recréer :

```bash
docker stop consul
docker rm consul
docker run -d --name consul -p 8500:8500 -p 8600:8600/udp hashicorp/consul:latest agent -dev -client "0.0.0.0"
```

---

## 🐳 Alternative : Utiliser Docker Compose

Pour démarrer Consul avec tous les autres services :

```bash
docker-compose up consul
```

Ou tout démarrer d'un coup :

```bash
docker-compose up --build
```

---

## ✅ Vérification Rapide

Ouvrez votre navigateur et allez sur : **http://localhost:8500**

Vous devriez voir l'interface Web de Consul avec :
- Section **Services** (vide pour l'instant)
- Section **Nodes**
- Section **Key/Value**

Une fois vos services démarrés, ils apparaîtront dans la section **Services** !

