
# Biding War

Biding War est une plateforme de vente aux enchères en ligne qui permet aux utilisateurs d'acheter, vendre ou participer à des enchères pour divers produits. La plateforme propose trois types d'utilisateurs : **acheteur (buyer)**, **vendeur (seller)**, et **les deux (both)**. Chaque type d'utilisateur a une barre de navigation personnalisée. Le côté administrateur est géré avec [Administrate](https://github.com/thoughtbot/administrate) et un système d'envoi de mails avec [MailDev](https://github.com/maildev/maildev).

## Fonctionnalités

- **Types d'utilisateurs** : Acheteur, Vendeur et les deux (Both).
- **FAQ personnalisée** : Chaque utilisateur a accès à une FAQ spécifique à son rôle. Les utilisateurs ayant le même rôle peuvent interagir dans cette FAQ pour poser des questions et partager des réponses. Les utilisateurs avec le rôle "Both" (à la fois acheteur et vendeur) ont accès à leur propre FAQ.
- **Tri par catégorie** : Les utilisateurs peuvent filtrer les produits en fonction de 4 catégories disponibles.
- **Recherche de produits** : Les utilisateurs peuvent rechercher un produit particulier en utilisant une barre de recherche.
- **Enchères en temps réel** : Les utilisateurs peuvent voir le temps restant pour les enchères et placer des offres en conséquence.
- **Système d'administration** : Géré par Administrate pour simplifier la gestion des utilisateurs, produits et enchères.
- **Intégration d'envoi de mails** : MailDev est utilisé pour simuler l'envoi d'e-mails en développement.

## Technologies utilisées

- **Backend** : Ruby on Rails
- **Frontend** : HTML, CSS (Bootstrap), JavaScript
- **Gestion des enchères** : Les produits sont affichés avec des informations comme le prix initial, le prix actuel et le temps restant avant la fin de l'enchère.
- **Système de FAQ** : Chaque utilisateur, selon son rôle (Acheteur, Vendeur, ou Both), a accès à une FAQ propre à son groupe, permettant des interactions spécifiques à leur rôle.
- **Bibliothèques** :
  - [Administrate](https://github.com/thoughtbot/administrate) : Pour l'interface d'administration.
  - [MailDev](https://github.com/maildev/maildev) : Simulateur d'envoi de mails.
  - [Bootstrap 4.5](https://getbootstrap.com/) : Pour le design et la réactivité de l'interface.

## Installation

1. Clonez le dépôt :
   ```bash
   git clone https://github.com/votre-projet/biding-war.git
   cd biding-war
   ```

2. Installez les dépendances :
   ```bash
   bundle install
   ```

3. Configurez la base de données :
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Peupler la base de données avec des utilisateurs, produits, et FAQ :
   Utilisez la commande `db:seed` pour générer des données de test :
   ```bash
   rails db:seed
   ```

5. Lancer le serveur MailDev :
   ```bash
   maildev
   ```

6. Démarrez le serveur :
   ```bash
   rails server
   ```

7. Accédez à l'application via votre navigateur :
   ```
   http://localhost:3000
   ```

## Utilisation

### Rôles d'utilisateurs
- **Acheteurs** : Accédez à la page des produits, placez vos enchères et surveillez les produits jusqu'à la fin de l'enchère.
- **Vendeurs** : Mettez vos produits en vente et définissez une date de fin d'enchère.
- **Both** : Enchérissez sur des produits et mettez les vôtres en vente simultanément.

### Tri et recherche de produits
- **Tri par catégorie** : Les utilisateurs peuvent filtrer les produits en fonction de 4 catégories disponibles sur la plateforme.
- **Recherche de produits** : Une barre de recherche est disponible pour permettre aux utilisateurs de trouver un produit spécifique en fonction de son nom ou d'autres critères.

### FAQ personnalisée
- **Acheteur** : Consultez et posez des questions spécifiques à l'achat de produits.
- **Vendeur** : Interagissez avec d'autres vendeurs sur des questions concernant la vente et la gestion des produits.
- **Both** : Les utilisateurs ayant ce rôle accèdent à une FAQ dédiée couvrant à la fois les aspects d'achat et de vente.

Les utilisateurs avec le même rôle peuvent interagir dans cette FAQ pour poser des questions et partager des réponses.

### Gestion du compte à rebours

Le projet utilise un script JavaScript pour gérer le compte à rebours des enchères. Lorsqu'une enchère se termine, un message "Enchère terminée" s'affiche, et l'utilisateur est redirigé vers l'historique des produits après 1 seconde.

## Liens

Notre liens Trello: https://trello.com/w/espacedetravailuser02049505
Notre Diagramme : /home/ouedraogo/Biding_war_par_Rahim_et_moi/Diagramme.drawio
Notre ancien Repos mentionner dans /Docs/modification.md/ : https://github.com/adama-traore-github/Biding_war.git
## Contribution

Les contributions sont les bienvenues ! Ouvrez une pull request ou soumettez un problème via GitHub.

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
```
