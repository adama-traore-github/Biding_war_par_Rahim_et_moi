Gestion des Paiements

Ce document décrit le système de paiement intégré dans le projet Biding War, y compris le flux de paiement, l'intégration avec un prestataire de paiement (comme Stripe), les validations, et les notifications de confirmation.
Fonctionnalités
1. Processus de Paiement

Une fois qu'une enchère est terminée et qu'un utilisateur a gagné, il doit effectuer le paiement pour l'objet remporté. Le paiement est géré via une plateforme de paiement sécurisée (comme Stripe).
Flux de paiement

    Notification de victoire : Lorsque l'enchère est clôturée, l'utilisateur gagnant reçoit une notification lui indiquant qu'il a remporté l'enchère et qu'il doit effectuer le paiement.
    Redirection vers la page de paiement : L'utilisateur est redirigé vers une page de paiement avec les détails de la transaction.
    Formulaire de paiement : Le formulaire inclut les informations suivantes :
        Montant total (incluant les frais éventuels).
        Méthode de paiement (carte de crédit, débit, etc.).
    Confirmation du paiement :
        Après la validation du paiement, une confirmation est envoyée à l'utilisateur.
        L'objet est alors marqué comme payé dans la base de données, et l'utilisateur peut organiser la livraison ou le retrait.

Exemple de flux utilisateur :

    L'utilisateur reçoit un email avec un lien vers la page de paiement après avoir remporté l'enchère.
    Il saisit ses informations de paiement et confirme.
    Une fois le paiement validé, une notification est envoyée, et l'objet est mis à disposition pour livraison.

2. Intégration avec Stripe (ou autre fournisseur de paiement)

Dans ce projet, Stripe est utilisé comme passerelle de paiement. L'intégration est réalisée via l'API Stripe pour traiter les transactions de manière sécurisée.

3. Confirmation de paiement
Flux de confirmation

    Une fois le paiement effectué, Stripe envoie une réponse à votre application indiquant si la transaction a réussi ou échoué.
    Si la transaction est réussie, l'application met à jour l'enchère dans la base de données, marquant l'objet comme payé.
    L'utilisateur reçoit une confirmation de paiement par email ou via une notification in-app.
    Un historique de transaction est également créé pour les administrateurs afin de suivre les paiements effectués sur la plateforme.

4. Gestion des Échecs de Paiement

En cas d'échec du paiement, l'utilisateur est redirigé vers une page lui indiquant que la transaction a échoué, et il peut réessayer de payer.
Règles de gestion des échecs

    Si un paiement échoue, la transaction est annulée, et l'utilisateur est invité à réessayer.
    Stripe gère automatiquement les erreurs de transaction, comme les cartes refusées ou les fonds insuffisants, et renvoie les informations correspondantes à l'application.
    Si le problème persiste, l'administrateur peut intervenir pour aider l'utilisateur à finaliser le paiement.

6. Historique et Reçus

Chaque paiement réussi est enregistré dans la base de données, et l'utilisateur peut accéder à un historique de ses paiements via son tableau de bord.

    Les utilisateurs peuvent voir :
        Les objets remportés.
        Le montant payé pour chaque enchère.
        Le statut de l'enchère (en attente, payée, en cours de livraison).