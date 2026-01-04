# Migration Eureka → Consul - Microservices Discovery

Ce projet démontre la migration d'un système de microservices de **Eureka** vers **Consul** pour la découverte de services.

## 📋 Objectifs

- Comprendre la logique d'une migration de service discovery (Eureka → Consul)
- Configurer Consul pour enregistrer et découvrir des microservices
- Conteneuriser et déployer l'ensemble avec Docker et Docker Compose

## 🛠️ Prérequis

- Docker et Docker Compose installés
- Java 11+ et Maven installés (pour développement local)
- Git installé
- Un IDE (IntelliJ IDEA, Eclipse, VS Code)

## 📦 Structure du Projet

```
ms-rest-template/
├── Client/              # Service Client avec Consul Discovery
├── Gateway/            # Service Gateway avec Consul Discovery
├── Server_Eureka/      # Serveur Eureka (legacy, optionnel)
├── docker-compose.yml  # Configuration Docker Compose
└── pom.xml            # POM parent
```

## 🚀 Guide de Migration

### Étape 1 — Importation et lancement des projets (état initial : Eureka)

#### 1.1 Cloner le dépôt

```bash
git clone https://github.com/lachgar/ms_rest_template.git
cd ms_rest_template
```

#### 1.2 Ouvrir les projets dans l'IDE

1. Ouvrir l'IDE (IntelliJ IDEA, Eclipse, VS Code)
2. Importer les projets Maven (Client, Gateway, Server_Eureka)
3. Vérifier que Maven télécharge correctement les dépendances :
   ```bash
   mvn clean install -DskipTests
   ```

#### 1.3 Démarrer les services (mode local)

Pour chaque service (dans un terminal séparé ou via l'IDE) :

```bash
# Terminal 1 - Client Service
cd Client
mvn spring-boot:run

# Terminal 2 - Gateway Service
cd Gateway
mvn spring-boot:run

# Terminal 3 - Eureka Server (optionnel, avant migration)
cd Server_Eureka
mvn spring-boot:run
```

#### 1.4 Vérifier que tout démarre correctement

- Vérifier les logs : pas d'erreurs bloquantes
- Vérifier les ports :
  - Client Service : http://localhost:8088
  - Gateway Service : http://localhost:8080
  - Eureka Server : http://localhost:8761 (si démarré)

---

### Étape 2 — Installation et démarrage de Consul (mode développement)

#### 2.1 Télécharger Consul

Aller sur le site officiel : https://www.consul.io/downloads

Télécharger la version adaptée à votre système d'exploitation.

#### 2.2 Installer Consul

**Windows :**
1. Décompresser l'archive (exemple : `C:\Consul`)
2. Ajouter au PATH : Variables d'environnement → PATH → ajouter `C:\Consul`

**Linux/macOS :**
```bash
# Exemple avec wget
wget https://releases.hashicorp.com/consul/1.17.0/consul_1.17.0_linux_amd64.zip
unzip consul_1.17.0_linux_amd64.zip
sudo mv consul /usr/local/bin/
```

#### 2.3 Lancer Consul en mode dev

```bash
# Windows
consul.exe agent -dev

# Linux/macOS
consul agent -dev
```

Ce mode est parfait pour un TP : il démarre rapidement et fonctionne sur une seule machine.

#### 2.4 Ouvrir l'interface Web de Consul

Ouvrir le navigateur : **http://localhost:8500/**

Vérifier que l'interface Consul s'affiche.

---

### Étape 3 — Migration des services : remplacer Eureka par Consul

#### 3.1 Principe de migration (ce qui change)

✅ **On ajoute :**
- Dépendance `spring-cloud-starter-consul-discovery`
- Configuration Consul dans `application.yml`
- Annotation `@EnableDiscoveryClient` (déjà présente)

❌ **On enlève :**
- Dépendance `spring-cloud-starter-netflix-eureka-client` (si présente)
- Propriétés Eureka dans `application.yml`

#### 3.2 Mise à jour des dépendances

Les `pom.xml` ont déjà été mis à jour avec :

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-consul-discovery</artifactId>
</dependency>
```

**Bon réflexe "pro" :**
```bash
# Valider la compilation après modification
mvn clean package -DskipTests
```

#### 3.3 Configuration application.yml

Les fichiers `application.yml` ont été configurés avec Consul :

**Client Service :**
```yaml
spring:
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: SERVICE-CLIENT
  application:
    name: SERVICE-CLIENT
```

**Gateway Service :**
```yaml
spring:
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: SERVICE-GATEWAY
  application:
    name: SERVICE-GATEWAY
```

#### 3.4 Activer la découverte côté Spring Boot

Les classes principales utilisent déjà `@EnableDiscoveryClient` :

```java
@SpringBootApplication
@EnableDiscoveryClient
public class ClientServiceApplication {
    // ...
}
```

---

### Étape 4 — Test et validation de la migration

#### 4.1 Redémarrer proprement

1. Arrêter tous les services (Client, Gateway, Server_Eureka)
2. Laisser Consul tourner
3. Relancer les services après modification :
   ```bash
   mvn spring-boot:run
   ```

#### 4.2 Vérifier l'enregistrement dans Consul

1. Ouvrir Consul UI : **http://localhost:8500/**
2. Aller dans la section **Services**
3. Vérifier que les services sont listés :
   - `SERVICE-CLIENT`
   - `SERVICE-GATEWAY`
4. Cliquer sur un service et vérifier :
   - Nombre d'instances
   - État de santé (passing/warning/critical)
   - Adresse/port

#### 4.3 Tester les endpoints

```bash
# Via Gateway
curl http://localhost:8080/api/client/info

# Directement
curl http://localhost:8088/api/client/info
```

---

## 🐳 Déploiement avec Docker Compose

### Démarrer tous les services

```bash
# Construire et démarrer tous les services
docker-compose up --build

# Ou en mode détaché
docker-compose up -d --build
```

### Vérifier les services

```bash
# Voir les logs
docker-compose logs -f

# Vérifier l'état
docker-compose ps

# Arrêter les services
docker-compose down
```

### Accès aux services

- **Consul UI** : http://localhost:8500
- **Gateway** : http://localhost:8080
- **Client Service** : http://localhost:8088
- **MySQL** : localhost:3309

---

## 📝 Points d'attention (style "pro")

1. **spring.application.name** est l'identifiant logique du service
2. **spring.cloud.consul.host/port** doivent pointer vers Consul (8500)
3. Les ports et URLs DB doivent correspondre à l'environnement
4. Vérifier qu'aucune annotation spécifique Eureka ne reste dans le code
5. Appliquer la même logique à tous les services concernés

---

## 🔍 Différences Eureka vs Consul

| Caractéristique | Eureka | Consul |
|----------------|--------|--------|
| Développeur | Netflix | HashiCorp |
| Focus | Découverte de services | Découverte + KV + Coordination |
| Interface Web | Oui | Oui (plus riche) |
| Health Checks | Basiques | Avancés |
| Configuration | Spring Cloud Netflix | Spring Cloud Consul |

---

## 📚 Remarque de clôture

La migration de Eureka vers Consul permet d'améliorer la résilience et la gestion des microservices. En suivant ces étapes, les projets utilisent désormais Consul pour la découverte de services.

---

## 🐛 Dépannage

### Consul ne démarre pas
- Vérifier que le port 8500 n'est pas utilisé : `netstat -an | findstr 8500`
- Vérifier les permissions d'exécution

### Les services ne s'enregistrent pas dans Consul
- Vérifier que Consul est démarré et accessible
- Vérifier la configuration `spring.cloud.consul.host` et `port`
- Vérifier les logs des services

### Erreurs de connexion MySQL
- Vérifier que MySQL écoute sur le port 3309
- Vérifier les credentials dans `application.yml`

---

## 📄 Licence

Ce projet est fourni à des fins éducatives.

