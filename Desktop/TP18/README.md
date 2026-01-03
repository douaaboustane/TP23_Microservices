# Service gRPC - Gestion de Comptes Bancaires

Ce projet implémente un service gRPC avec Spring Boot pour gérer des comptes bancaires.

## Structure du Projet

```
TP18/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ma/projet/grpc/
│   │   │       ├── GrpcServiceApplication.java
│   │   │       ├── controllers/
│   │   │       │   └── CompteServiceImpl.java
│   │   │       ├── entities/
│   │   │       │   └── Compte.java
│   │   │       ├── repositories/
│   │   │       │   └── CompteRepository.java
│   │   │       └── services/
│   │   │           └── CompteService.java
│   │   ├── proto/
│   │   │   └── CompteService.proto
│   │   └── resources/
│   │       └── application.properties
└── README.md
```

## Prérequis

- Java 20
- Maven 3.6+

## Installation et Exécution

1. **Compiler le projet et générer les classes Protobuf :**
   ```bash
   mvn clean compile
   ```

2. **Lancer l'application :**
   ```bash
   mvn spring-boot:run
   ```

   Le serveur gRPC sera accessible sur le port **9090**.

## Configuration

Le fichier `application.properties` configure :
- Port gRPC : 9090
- Base de données H2 en mémoire
- Console H2 accessible sur `/h2-console`

## Test avec BloomRPC

1. Télécharger et installer [BloomRPC](https://github.com/bloomrpc/bloomrpc)
2. Ouvrir BloomRPC
3. Importer le fichier `src/main/proto/CompteService.proto`
4. Configurer le serveur : `localhost:9090`
5. Tester les méthodes :
   - `AllComptes` : Récupère tous les comptes
   - `CompteById` : Récupère un compte par ID
   - `TotalSolde` : Calcule les statistiques de solde
   - `SaveCompte` : Crée un nouveau compte

## Exemples de Requêtes

### SaveCompte
```json
{
  "compte": {
    "solde": 1000.0,
    "dateCreation": "2024-01-15",
    "type": "COURANT"
  }
}
```

### CompteById
```json
{
  "id": "uuid-du-compte"
}
```

### AllComptes
```json
{}
```

### TotalSolde
```json
{}
```

## Fonctionnalités

- ✅ Création de comptes bancaires
- ✅ Consultation de tous les comptes
- ✅ Consultation d'un compte par ID
- ✅ Calcul des statistiques de solde (nombre, somme, moyenne)
- ✅ Persistance avec H2 Database et JPA

