# Solution Rapide pour Résoudre les Erreurs de Compilation

## Le Problème
Les classes Protobuf (`CompteServiceGrpc`, `GetAllComptesRequest`, etc.) ne sont pas générées, ce qui cause des erreurs de compilation.

## Solution Immédiate dans IntelliJ IDEA

### Méthode 1 : Via le Menu Maven (RECOMMANDÉ)

1. **Ouvrir la fenêtre Maven** :
   - Menu : `View` → `Tool Windows` → `Maven`
   - Ou clic droit sur `pom.xml` → `Show in Maven`

2. **Recharger le projet Maven** :
   - Dans la fenêtre Maven, cliquer sur l'icône "Reload All Maven Projects" (flèche circulaire)
   - Ou : Clic droit sur le projet → `Maven` → `Reload Project`

3. **Générer les sources Protobuf** :
   - Dans la fenêtre Maven, développer : `TP18` → `Plugins` → `protobuf` → `protobuf:compile`
   - Double-cliquer sur `protobuf:compile` pour générer les classes Protobuf
   - Double-cliquer sur `protobuf:compile-custom` pour générer les classes gRPC

4. **Ajouter les sources générées au projet** :
   - Clic droit sur le projet → `Maven` → `Generate Sources and Update Folders`
   - Ou : Menu `Build` → `Rebuild Project`

### Méthode 2 : Via la Palette de Commandes

1. Appuyer sur `Ctrl + Shift + A` (ou `Cmd + Shift + A` sur Mac)
2. Taper : `Maven: Generate Sources and Update Folders`
3. Appuyer sur Entrée

### Méthode 3 : Via le Terminal Intégré

1. Ouvrir le terminal intégré : `Alt + F12`
2. Exécuter :
   ```bash
   mvn clean compile
   ```

### Méthode 4 : Forcer la Génération

1. Menu : `File` → `Invalidate Caches / Restart...`
2. Sélectionner : `Invalidate and Restart`
3. Après le redémarrage, IntelliJ devrait automatiquement générer les sources

## Vérification

Après avoir exécuté une des méthodes ci-dessus, vérifiez que les classes sont générées :

1. Dans l'explorateur de projet, développez : `target` → `generated-sources` → `protobuf`
2. Vous devriez voir :
   - `java/ma/projet/grpc/stubs/` (contient les messages Protobuf)
   - `grpc-java/ma/projet/grpc/stubs/` (contient les classes gRPC)

3. Les classes suivantes doivent exister :
   - `CompteServiceGrpc.java`
   - `GetAllComptesRequest.java`
   - `GetAllComptesResponse.java`
   - `Compte.java`
   - `TypeCompte.java`
   - Et toutes les autres classes définies dans `CompteService.proto`

## Si ça ne fonctionne toujours pas

1. **Vérifier que le fichier `.proto` est au bon endroit** :
   - Doit être dans : `src/main/proto/CompteService.proto`

2. **Vérifier la configuration Maven** :
   - Menu : `File` → `Settings` → `Build, Execution, Deployment` → `Build Tools` → `Maven`
   - Vérifier que "Maven home directory" est correctement configuré

3. **Nettoyer et reconstruire** :
   - Menu : `Build` → `Clean Project`
   - Puis : `Build` → `Rebuild Project`

4. **Vérifier les logs Maven** :
   - Dans la fenêtre Maven, regarder les logs lors de l'exécution de `protobuf:compile`
   - Vérifier s'il y a des erreurs

## Note Importante

Les classes Protobuf sont générées automatiquement lors de la compilation Maven. Si votre IDE ne les génère pas automatiquement, vous devez forcer la génération en utilisant une des méthodes ci-dessus.

