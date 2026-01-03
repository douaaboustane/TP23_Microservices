# Instructions pour résoudre les erreurs de compilation

## Problème
Les classes générées par Protobuf (CompteServiceGrpc, GetAllComptesRequest, etc.) ne sont pas trouvées car elles n'ont pas encore été générées.

## Solution

### Option 1 : Utiliser Maven (Recommandé)

1. **Installer Maven** (si pas déjà installé) :
   - Télécharger depuis : https://maven.apache.org/download.cgi
   - Extraire et ajouter au PATH
   - Vérifier l'installation : `mvn --version`

2. **Compiler le projet** :
   ```bash
   mvn clean compile
   ```
   
   Cette commande va :
   - Générer les classes Java à partir du fichier `.proto`
   - Compiler tout le projet
   - Résoudre les erreurs de compilation

3. **Lancer l'application** :
   ```bash
   mvn spring-boot:run
   ```

### Option 2 : Utiliser l'IDE (IntelliJ IDEA / Eclipse)

#### IntelliJ IDEA :
1. Ouvrir le projet
2. Clic droit sur `pom.xml` → `Maven` → `Reload Project`
3. Clic droit sur `pom.xml` → `Maven` → `Generate Sources and Update Folders`
4. Ou utiliser : `View` → `Tool Windows` → `Maven` → Exécuter `compile`

#### Eclipse :
1. Clic droit sur le projet → `Maven` → `Update Project...`
2. Clic droit sur le projet → `Run As` → `Maven build...`
3. Entrer `clean compile` dans les goals

### Option 3 : Utiliser Maven Wrapper (si disponible)

Si le projet contient `mvnw` (Maven Wrapper) :
```bash
./mvnw clean compile
```

## Vérification

Après la compilation, vous devriez voir les classes générées dans :
- `target/generated-sources/protobuf/java/ma/projet/grpc/stubs/`
- `target/generated-sources/protobuf/grpc-java/ma/projet/grpc/stubs/`

Ces classes incluent :
- `CompteServiceGrpc`
- `GetAllComptesRequest`
- `GetAllComptesResponse`
- `Compte`
- `TypeCompte`
- Et toutes les autres classes définies dans `CompteService.proto`

## Note importante

Les classes Protobuf doivent être générées **avant** que le code Java puisse compiler. C'est pourquoi vous devez exécuter `mvn clean compile` au moins une fois.

