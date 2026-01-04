# 🚀 Comment Démarrer les Services

## ⚠️ Erreur Commune

Si vous obtenez cette erreur :
```
Unable to find a suitable main class, please add a 'mainClass' property
```

C'est parce que vous essayez de lancer `mvn spring-boot:run` depuis le **répertoire racine** (le POM parent).

Le POM parent est un projet multi-modules (`<packaging>pom</packaging>`) et n'a **pas de classe principale** à exécuter.

---

## ✅ Solution : Démarrer depuis les Modules

Vous devez démarrer chaque service depuis **son propre répertoire**.

### Option 1 : Démarrer les Services Individuellement

#### Terminal 1 - Service Client

```bash
cd Client
mvn spring-boot:run
```

Le service Client démarrera sur le port **8088**.

#### Terminal 2 - Service Gateway

```bash
cd Gateway
mvn spring-boot:run
```

Le service Gateway démarrera sur le port **8080**.

---

### Option 2 : Compiler d'abord, puis exécuter

#### Étape 1 : Compiler tous les projets

Depuis le répertoire racine :
```bash
mvn clean install -DskipTests
```

#### Étape 2 : Démarrer les services

**Terminal 1 - Client :**
```bash
cd Client
mvn spring-boot:run
```

**Terminal 2 - Gateway :**
```bash
cd Gateway
mvn spring-boot:run
```

---

## 🐳 Option 3 : Utiliser Docker Compose (Recommandé)

Pour démarrer tous les services d'un coup (Consul + MySQL + Services) :

```bash
docker-compose up --build
```

Ou en arrière-plan :
```bash
docker-compose up -d --build
```

---

## 📋 Ordre de Démarrage Recommandé

1. ✅ **Consul** (déjà démarré via Docker)
   - Vérifier : http://localhost:8500

2. ✅ **MySQL** (si nécessaire, ou via Docker Compose)
   - Port : 3309

3. ⏭️ **Service Client**
   ```bash
   cd Client
   mvn spring-boot:run
   ```
   - Port : 8088
   - Vérifier : http://localhost:8088/api/client/info

4. ⏭️ **Service Gateway**
   ```bash
   cd Gateway
   mvn spring-boot:run
   ```
   - Port : 8080
   - Vérifier : http://localhost:8080/api/client/info

---

## ✅ Vérification

### 1. Vérifier que les services sont enregistrés dans Consul

Ouvrir : **http://localhost:8500**

Aller dans la section **Services** et vérifier que vous voyez :
- `SERVICE-CLIENT`
- `SERVICE-GATEWAY`

### 2. Tester les endpoints

```bash
# Service Client direct
curl http://localhost:8088/api/client/info

# Via Gateway
curl http://localhost:8080/api/client/info

# Health check
curl http://localhost:8088/api/client/health
```

---

## 🔧 Dépannage

### Erreur : Port déjà utilisé

Si le port 8088 ou 8080 est déjà utilisé :

**Windows :**
```bash
netstat -ano | findstr :8088
netstat -ano | findstr :8080
```

**Solution :** Arrêter le processus ou changer le port dans `application.yml`

### Erreur : Consul non accessible

Vérifier que Consul est démarré :
```bash
docker ps | findstr consul
```

Si non, démarrer Consul :
```bash
docker run -d --name consul -p 8500:8500 -p 8600:8600/udp hashicorp/consul:latest agent -dev -client "0.0.0.0"
```

### Erreur : MySQL non accessible

Vérifier que MySQL est démarré et écoute sur le port 3309.

Ou utiliser Docker Compose qui démarre tout automatiquement.

---

## 📝 Scripts Utiles

### Script pour démarrer Client (Windows)

Créer `start-client.bat` :
```batch
@echo off
cd Client
mvn spring-boot:run
pause
```

### Script pour démarrer Gateway (Windows)

Créer `start-gateway.bat` :
```batch
@echo off
cd Gateway
mvn spring-boot:run
pause
```

---

## 🎯 Résumé

❌ **NE PAS faire :**
```bash
# Depuis la racine
mvn spring-boot:run
```

✅ **FAIRE :**
```bash
# Depuis le module Client
cd Client
mvn spring-boot:run

# Depuis le module Gateway
cd Gateway
mvn spring-boot:run
```

Ou utiliser Docker Compose pour tout démarrer automatiquement !

