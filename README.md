# tezos_project

Consignes: 
Ecrire un smart contract de vote qui permet à plusieurs utilisateurs de voter:
•	2 vote  possible ("yes"  or "no")
•	Tous les utilisateurs ont le droit de voter
•	Un utilisateur doit pouvoir ne voter qu'une seule fois
•	Le contrat doit avoir un super utilisateur (admin) et son adresse est initialisé au déploiement du contrat
•	L'administrateur n'a pas le droit de voter
•	Le smart contrat doit être mis en pause si 10 personnes ont voté.
•	Quand le smart contract est mis en pause, le résultat du vote doit être calculé et stocké dans le storage.
•	L'administrateur doit pouvoir remettre à zéro le contrat (effacer les votes) + enlever la pause

Arborescence du projet : 
Créer un dossier mycontrat. Puis créer 2 sous-dossiers src et tests. Dans le dossier src nous créerons notre contrat ligo et dans le dossier tests le script pytest pour les tests unitaires.

Création d’un fichier ligo dans le dossier src :
nano vote_final.ligo

Instructions de compilation : 
ligo compile-contract vote_final.ligo main

Déploiement : 
Commande : ligo dry_run

Commande finale : 
ligo dry-run --sender=tz3VEZ4k6a4Wx42iyev6i2aVAptTRLEAivNN vote_v3.ligo main 'Vote("yes")' 'record voteofuser=map ("tz1gfArv665EUkSg2ojMBzcbfwuPxAvqPvjo" : address) -> "no"; ("tz3bTdwZinP8U1JmSweNzVKhmwafqWmFWRfk" : address) -> "yes";("tz3bTdwZinP8U1JmSweNzVKhmwafqWmFWRfk" : address) -> "yes"; ("tz3VEZ4k6a4Wx42iyev6i2aVAptTRLEAivNN" : address) -> "yes";end; owner=("tz1VPFYwwtWZ5ytH5ZcMYyvqi9AmiR3d8sJT":address); int_yes=0; int_no=0; contractPause=False; end' 
Le sender est comparé à l’adresse de l’owner. L’administrateur ne doit pas voter.

Finalement :
( list[] , record[contractPause -> true , int_no -> 1 , int_yes -> 2 , owner -> @"tz1VPFYwwtWZ5ytH5ZcMYyvqi9AmiR3d8sJT" , voteofuser -> map[@"tz1gfArv665EUkSg2ojMBzcbfwuPxAvqPvjo" -> "no" , @"tz3VEZ4k6a4Wx42iyev6i2aVAptTRLEAivNN" -> "yes" , @"tz3bTdwZinP8U1JmSweNzVKhmwafqWmFWRfk" -> "yes"]] )
Remarque :  dans le contrat pas failwith pour pouvoir voir le résultat du vote et la pause du contrat. Donc constater de l’état final du storage.
Création d’un fichier python dans le dossier tests :
nano pytest-vote.py

Déploiement : 
Commande : pytest pytest-vote.py


