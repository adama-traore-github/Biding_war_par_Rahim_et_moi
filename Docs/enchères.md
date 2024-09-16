Gestion des Enchères

Ce document décrit le fonctionnement du système d'enchères dans le projet Biding War, y compris la création d'une enchère, la participation des utilisateurs, la gestion des mises, et les règles de validation.
Fonctionnalités
1. Création d'une Enchère

Seuls les utilisateurs autorisés (par exemple, administrateurs ou vendeurs approuvés) peuvent créer une enchère pour un objet. Voici les étapes pour créer une enchère :

    Formulaire de création d'une enchère :
        Titre de l'enchère : Obligatoire, longueur maximale de 100 caractères.
        Description : Une description détaillée de l'objet mis aux enchères.
        Prix de départ : Le prix de départ de l'enchère (validation pour assurer qu'il est supérieur à zéro).
        Date de début et de fin : Période pendant laquelle les utilisateurs peuvent soumettre des mises.
        Image de l'objet (facultatif) : Téléchargement d'une ou plusieurs images pour illustrer l'objet.

Flux de la création

    L'utilisateur remplit le formulaire de création d'enchère avec les détails de l'objet.
    Les validations côté serveur vérifient les données (par exemple, le prix de départ, les dates).
    Si la création réussit, l'enchère est enregistrée et devient visible pour tous les utilisateurs à partir de la date de début spécifiée.

2. Participation aux Enchères (Mises)

Les utilisateurs peuvent participer à une enchère en plaçant des mises pendant la période d'enchère (entre la date de début et la date de fin).

    Conditions pour une mise valide :
        Le montant de la mise doit être supérieur à la mise actuelle la plus élevée (ou au prix de départ si aucune mise n'a encore été placée).
        Les utilisateurs doivent être authentifiés pour pouvoir placer une mise.

Flux de participation

    Un utilisateur navigue vers une enchère en cours.
    Il entre un montant supérieur à l'enchère actuelle et soumet sa mise.
    Le serveur vérifie si le montant est valide et si l'enchère est toujours active.
    Si la mise est acceptée, elle devient la mise actuelle la plus élevée, et l'utilisateur reçoit une notification de succès.

3. Fin de l'enchère et notification du gagnant

Lorsque la date de fin d'une enchère est atteinte, l'enchère est clôturée et l'utilisateur ayant fait la mise la plus élevée est déclaré gagnant.
Flux de clôture

    À la fin de l'enchère (basée sur la date de fin), le système arrête d'accepter des mises.
    L'utilisateur ayant la mise la plus élevée est notifié par email ou via une notification in-app (selon les fonctionnalités).
    Une fois l'enchère terminée, l'administrateur peut vérifier et valider la transaction pour passer à la phase de paiement.

4. Règles de Validation
Validation des mises

    Les utilisateurs ne peuvent soumettre qu'une mise supérieure à la mise actuelle la plus élevée.
    Les mises ne peuvent être placées qu'entre la date de début et la date de fin de l'enchère.

Validation de la clôture

    Les enchères se ferment automatiquement à la date et heure de fin spécifiées.
    Après clôture, aucune nouvelle mise ne peut être acceptée.

5. Interface utilisateur

L'interface pour les enchères est intuitive et permet aux utilisateurs de :

    Voir la liste des enchères disponibles (avec une recherche et des filtres).
    Voir les détails d'une enchère spécifique (titre, description, mise actuelle, nombre de mises, etc.).
    Placer une nouvelle mise directement depuis la page de détail de l'enchère.

6. Notifications

Les utilisateurs reçoivent des notifications à différents moments :

    Confirmation de mise : Chaque fois qu'une mise est placée avec succès.
    Notification de surenchère : Si un utilisateur est surenchéri par un autre participant.
    Notification de gain : Lorsque l'enchère se termine, le gagnant reçoit une notification l'informant de la prochaine étape.