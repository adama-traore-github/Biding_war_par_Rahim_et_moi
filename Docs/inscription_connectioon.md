**Inscription et Connexion des Utilisateurs**

Ce document décrit le processus d'inscription et de connexion des utilisateurs pour le projet Biding War, y compris les différentes validations et les étapes techniques mises en place.
Fonctionnalités
1. Inscription

L'inscription permet à un nouvel utilisateur de créer un compte sur la plateforme pour pouvoir participer aux enchères. L'inscription inclut :

    Un formulaire avec des champs obligatoires tels que :
        Nom d'utilisateur : Unicité garantie via une validation.
        Adresse e-mail : Validation du format et unicité.
        Mot de passe : Minimum de 6 caractères, confirmation du mot de passe.
        Roles : Acheteur, Vendeur ou les deux

Flux de l'inscription

    L'utilisateur remplit le formulaire d'inscription.
    Les validations côté serveur (via les modèles Rails) vérifient l'unicité de l'email et du nom d'utilisateur, ainsi que la sécurité du mot de passe.
    Après validation, l'utilisateur reçoit un email de confirmation pour activer son compte (si l'option est activée via un gem comme Devise).
    Une fois l'email confirmé, l'utilisateur est redirigé vers la page de connexion.

2. Connexion

La connexion permet à un utilisateur enregistré de se connecter pour accéder à son compte et participer aux enchères.
Flux de la connexion

    L'utilisateur accède à la page de connexion et saisit son email et son mot de passe.
    Si les identifiants sont valides, une session utilisateur est créée et l'utilisateur est redirigé vers la page d'accueil ou une page spécifique.
    En cas d'erreur, un message est affiché indiquant que l'email ou le mot de passe est incorrect.

3. Réinitialisation du mot de passe

Les utilisateurs peuvent réinitialiser leur mot de passe en utilisant la fonctionnalité "Mot de passe oublié". Voici comment cela fonctionne :

    L'utilisateur clique sur "Mot de passe oublié" sur la page de connexion.
    Il entre son adresse e-mail dans le formulaire.
    Un e-mail contenant un lien de réinitialisation du mot de passe est envoyé à l'utilisateur.
    En cliquant sur le lien, l'utilisateur peut entrer un nouveau mot de passe.

4. Déconnexion

La déconnexion est une action simple qui permet à un utilisateur de quitter son compte. 