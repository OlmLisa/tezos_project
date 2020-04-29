
#*************************************************************#
# TEZOS PROJECT 3A IBC ESGI                                   #
# Developed By Lisa OULMI                                     #
# Version Bêta                                                #
# Copyright ©2020                                             #
#*************************************************************#

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

#*************************************************************#

Arborescence du projet : 
Créer un dossier mycontrat. Puis créer 2 sous-dossiers src et tests. Dans le dossier src nous créerons notre contrat ligo et dans le dossier tests le script pytest pour les tests unitaires.

#*************************************************************#
Création d’un fichier ligo dans le dossier src :
nano vote_final.ligo

Instruction de compilation : 
ligo compile-contract vote_final.ligo main

Déploiement : 
Commande : ligo dry_run

Commande finale : 
ligo dry-run --sender=tz1MGTFJXpQmtxLi8QJ7AuVRgM2L2Qfn9w9i vote_v3.ligo main 'Vote("yes")' 'record voteofuser=map ("tz1gfArv665EUkSg2ojMBzcbfwuPxAvqPvjo" : address) -> "no"; ("tz3bvNMQ95vfAYtG8193ymshqjSvmxiCUuR5" : address) -> "yes";("tz3bTdwZinP8U1JmSweNzVKhmwafqWmFWRfk" : address) -> "yes"; ("tz3VEZ4k6a4Wx42iyev6i2aVAptTRLEAivNN" : address) -> "yes";end; owner=("tz1VPFYwwtWZ5ytH5ZcMYyvqi9AmiR3d8sJT":address); int_yes=0; int_no=0; contractPause=False; end' 

Le sender est comparé à l’adresse de l’owner. L’administrateur ne doit pas voter.
Puis pour tester les 10 votes, entrer 10 votes dans le storage comme ci-dessus avec 4 votes.
Au bout de 10 votes, résultat des votes et contratPause est True.

Finalement : par exemple en mettant la limite à 3 votes et non 10 on obtient : 
( list[] , record[contractPause -> true , int_no -> 1 , int_yes -> 2 , owner -> @"tz1VPFYwwtWZ5ytH5ZcMYyvqi9AmiR3d8sJT" , voteofuser -> map[@"tz1gfArv665EUkSg2ojMBzcbfwuPxAvqPvjo" -> "no" , @"tz3VEZ4k6a4Wx42iyev6i2aVAptTRLEAivNN" -> "yes" , @"tz3bTdwZinP8U1JmSweNzVKhmwafqWmFWRfk" -> "yes"]] )

#*************************************************************#

Création d’un fichier python dans le dossier tests :
nano pytest-vote.py

Déploiement : 
Commande : pytest pytest-vote.py

#*************************************************************#

Résultat après compilation du contrat vote_final.ligo on obtient :

{ parameter (or (or (bool %pause) (address %setAdmin)) (string %vote)) ;
  storage
    (pair (pair (pair (bool %contractPause) (int %int_no)) (pair (int %int_yes) (address %owner)))
          (map %voteofuser address string)) ;
  code { DUP ;
         LAMBDA address bool { DUP ; SENDER ; COMPARE ; EQ ; DIP { DROP } } ;
         SWAP ;
         CDR ;
         DIP 2 { DUP } ;
         DIG 2 ;
         CAR ;
         IF_LEFT
           { DUP ;
             IF_LEFT
               { DIP 2 { DUP } ;
                 DIG 2 ;
                 DUP ;
                 DIP { DUP } ;
                 SWAP ;
                 CAR ;
                 CDR ;
                 CDR ;
                 DIP { DIP 5 { DUP } ; DIG 5 } ;
                 EXEC ;
                 IF { DIP { DUP } ;
                      SWAP ;
                      DUP ;
                      CDR ;
                      SWAP ;
                      CAR ;
                      DUP ;
                      CDR ;
                      SWAP ;
                      CAR ;
                      CDR ;
                      PUSH bool True ;
                      PAIR ;
                      PAIR ;
                      PAIR ;
                      DUP ;
                      DUP ;
                      CDR ;
                      SWAP ;
                      CAR ;
                      DUP ;
                      CAR ;
                      SWAP ;
                      CDR ;
                      CDR ;
                      PUSH int 0 ;
                      PAIR ;
                      SWAP ;
                      PAIR ;
                      PAIR ;
                      DIP 2 { DUP } ;
                      DIG 2 ;
                      DIP 2 { DUP } ;
                      DIG 2 ;
                      DIP { DROP ; DUP } ;
                      SWAP ;
                      DIP { DROP ; DUP } ;
                      SWAP ;
                      DUP ;
                      CDR ;
                      SWAP ;
                      CAR ;
                      DUP ;
                      CDR ;
                      SWAP ;
                      CAR ;
                      CAR ;
                      PUSH int 0 ;
                      SWAP ;
                      PAIR ;
                      PAIR ;
                      PAIR ;
                      DIP { DROP 3 } }
                    { PUSH string "You have to be admin to setPause" ; FAILWITH } ;
                 DUP ;
                 DIP { DROP 4 } }
               { DIP 2 { DUP } ;
                 DIG 2 ;
                 DIP { DUP } ;
                 PAIR ;
                 DUP ;
                 CAR ;
                 DIP { DUP } ;
                 SWAP ;
                 CDR ;
                 DUP ;
                 DIP { DIP { DUP } ; SWAP } ;
                 PAIR ;
                 DIP 2 { DUP } ;
                 DIG 2 ;
                 CAR ;
                 CDR ;
                 CDR ;
                 DIP { DIP 7 { DUP } ; DIG 7 } ;
                 EXEC ;
                 IF { DUP ;
                      DIP 3 { DUP } ;
                      DIG 3 ;
                      DIP 3 { DUP } ;
                      DIG 3 ;
                      DIP { DUP ; CDR ; SWAP ; CAR ; DUP ; CAR ; SWAP ; CDR ; CAR } ;
                      SWAP ;
                      PAIR ;
                      SWAP ;
                      PAIR ;
                      PAIR ;
                      SWAP ;
                      CAR ;
                      PAIR }
                    { PUSH string "Bad setadm" ; FAILWITH } ;
                 DUP ;
                 CDR ;
                 DIP { DROP 6 } } ;
             DIP { DROP } }
           { DIP { DUP } ;
             SWAP ;
             DIP { DUP } ;
             PAIR ;
             DUP ;
             CAR ;
             DIP { DUP } ;
             SWAP ;
             CDR ;
             DIP { DUP } ;
             SWAP ;
             DIP 2 { DUP } ;
             DIG 2 ;
             CAR ;
             CDR ;
             CDR ;
             DIP { DIP 6 { DUP } ; DIG 6 } ;
             EXEC ;
             NOT ;
             IF { DIP 2 { DUP } ;
                  DIG 2 ;
                  CDR ;
                  SIZE ;
                  DIP 3 { DUP } ;
                  DIG 3 ;
                  DIP { DUP } ;
                  SWAP ;
                  DIP { PUSH int 10 ; ABS } ;
                  COMPARE ;
                  EQ ;
                  IF { DIP 4 { DUP } ;
                       DIG 4 ;
                       CDR ;
                       DIP { PUSH int 0 ;
                             PUSH int 0 ;
                             PAIR ;
                             DIP { DIP 4 { DUP } ; DIG 4 } ;
                             PAIR } ;
                       ITER { SWAP ;
                              PAIR ;
                              DUP ;
                              CAR ;
                              CAR ;
                              CAR ;
                              DIP { DUP } ;
                              SWAP ;
                              CAR ;
                              CAR ;
                              CDR ;
                              DIP 2 { DUP } ;
                              DIG 2 ;
                              CAR ;
                              CDR ;
                              DIP 2 { DUP } ;
                              DIG 2 ;
                              DIP { DIP { DUP } ; SWAP } ;
                              PAIR ;
                              DIP { DUP } ;
                              PAIR ;
                              DIP 4 { DUP } ;
                              DIG 4 ;
                              CDR ;
                              CDR ;
                              PUSH string "yes" ;
                              SWAP ;
                              COMPARE ;
                              EQ ;
                              IF { DIP { DUP } ;
                                   SWAP ;
                                   DIP 3 { DUP } ;
                                   DIG 3 ;
                                   PUSH int 1 ;
                                   ADD ;
                                   DIP { DUP ; CDR ; SWAP ; CAR ; DUP ; CAR ; SWAP ; CDR ; CDR } ;
                                   PAIR ;
                                   SWAP ;
                                   PAIR ;
                                   PAIR ;
                                   DIP 3 { DUP } ;
                                   DIG 3 ;
                                   PUSH int 1 ;
                                   ADD ;
                                   DIP 2 { DUP } ;
                                   DIG 2 ;
                                   DIP 2 { DUP } ;
                                   DIG 2 ;
                                   SWAP ;
                                   CAR ;
                                   PAIR ;
                                   DIP { DUP } ;
                                   SWAP ;
                                   DIP { DUP ; CDR ; SWAP ; CAR ; CAR } ;
                                   SWAP ;
                                   PAIR ;
                                   PAIR ;
                                   DIP { DROP 2 } }
                                 { DIP { DUP } ;
                                   SWAP ;
                                   DIP 4 { DUP } ;
                                   DIG 4 ;
                                   PUSH int 1 ;
                                   ADD ;
                                   DIP { DUP ; CDR ; SWAP ; CAR ; DUP ; CDR ; SWAP ; CAR ; CAR } ;
                                   SWAP ;
                                   PAIR ;
                                   PAIR ;
                                   PAIR ;
                                   DIP 4 { DUP } ;
                                   DIG 4 ;
                                   PUSH int 1 ;
                                   ADD ;
                                   DIP 2 { DUP } ;
                                   DIG 2 ;
                                   DIP 2 { DUP } ;
                                   DIG 2 ;
                                   SWAP ;
                                   CAR ;
                                   PAIR ;
                                   DIP { DUP } ;
                                   SWAP ;
                                   DIP { DUP ; CDR ; SWAP ; CAR ; CDR } ;
                                   PAIR ;
                                   PAIR ;
                                   DIP { DROP 2 } } ;
                              DIP 5 { DUP } ;
                              DIG 5 ;
                              DIP 6 { DUP } ;
                              DIG 6 ;
                              CAR ;
                              DIP 2 { DUP } ;
                              DIG 2 ;
                              CAR ;
                              CDR ;
                              DIP { DUP ; CDR ; SWAP ; CAR ; CAR } ;
                              SWAP ;
                              PAIR ;
                              PAIR ;
                              SWAP ;
                              CDR ;
                              SWAP ;
                              PAIR ;
                              DUP ;
                              DIP { DUP } ;
                              SWAP ;
                              CAR ;
                              DIP 3 { DUP } ;
                              DIG 3 ;
                              CDR ;
                              SWAP ;
                              CAR ;
                              PAIR ;
                              SWAP ;
                              CDR ;
                              SWAP ;
                              PAIR ;
                              DUP ;
                              DIP { DUP } ;
                              SWAP ;
                              CAR ;
                              DIP 4 { DUP } ;
                              DIG 4 ;
                              CAR ;
                              CAR ;
                              DIP { DUP ; CDR ; SWAP ; CAR ; CDR } ;
                              PAIR ;
                              PAIR ;
                              SWAP ;
                              CDR ;
                              SWAP ;
                              PAIR ;
                              DUP ;
                              DIP { DUP } ;
                              SWAP ;
                              CAR ;
                              DIP 5 { DUP } ;
                              DIG 5 ;
                              CDR ;
                              SWAP ;
                              CAR ;
                              PAIR ;
                              SWAP ;
                              CDR ;
                              SWAP ;
                              PAIR ;
                              CAR ;
                              DIP { DROP 9 } } ;
                       DIP { DUP } ;
                       SWAP ;
                       DIP { DUP } ;
                       SWAP ;
                       CDR ;
                       DIP { DROP 2 } }
                     { DIP 4 { DUP } ;
                       DIG 4 ;
                       DUP ;
                       CDR ;
                       SWAP ;
                       CAR ;
                       DUP ;
                       CAR ;
                       SWAP ;
                       CDR ;
                       CDR ;
                       PUSH int 0 ;
                       PAIR ;
                       SWAP ;
                       PAIR ;
                       PAIR ;
                       DIP { DUP } ;
                       SWAP ;
                       DIP { DUP } ;
                       SWAP ;
                       DIP { DROP ; DUP } ;
                       SWAP ;
                       DUP ;
                       CDR ;
                       SWAP ;
                       CAR ;
                       DUP ;
                       CDR ;
                       SWAP ;
                       CAR ;
                       CAR ;
                       PUSH int 0 ;
                       SWAP ;
                       PAIR ;
                       PAIR ;
                       PAIR ;
                       DIP { DROP 2 } } ;
                  DIP 3 { DUP } ;
                  DIG 3 ;
                  DIP { DUP } ;
                  SWAP ;
                  DIP { DROP ; DUP } ;
                  SWAP ;
                  DIP { DROP 4 } }
                { PUSH string "Burn : admin cannot vote" ; FAILWITH } ;
             DUP ;
             DUP ;
             DIP { DIP 3 { DUP } ; DIG 3 } ;
             PAIR ;
             DIP { DUP } ;
             SWAP ;
             CAR ;
             CDR ;
             CDR ;
             DIP { DIP 9 { DUP } ; DIG 9 } ;
             EXEC ;
             NOT ;
             IF { DIP { DUP } ;
                  SWAP ;
                  DIP { DIP 4 { DUP } ; DIG 4 } ;
                  PAIR ;
                  DIP 2 { DUP } ;
                  DIG 2 ;
                  CAR ;
                  CAR ;
                  CAR ;
                  IF { DUP ;
                       DIP 3 { DUP } ;
                       DIG 3 ;
                       DIP 7 { DUP } ;
                       DIG 7 ;
                       SOME ;
                       DIP { DIP 4 { DUP } ; DIG 4 ; CDR } ;
                       SENDER ;
                       UPDATE ;
                       SWAP ;
                       CAR ;
                       PAIR ;
                       SWAP ;
                       CDR ;
                       SWAP ;
                       PAIR }
                     { DUP ;
                       DIP 3 { DUP } ;
                       DIG 3 ;
                       DUP ;
                       CDR ;
                       SWAP ;
                       CAR ;
                       DUP ;
                       CDR ;
                       SWAP ;
                       CAR ;
                       CDR ;
                       PUSH bool True ;
                       PAIR ;
                       PAIR ;
                       PAIR ;
                       SWAP ;
                       CDR ;
                       SWAP ;
                       PAIR } ;
                  DIP 2 { DUP } ;
                  DIG 2 ;
                  DIP { DUP } ;
                  SWAP ;
                  CDR ;
                  SWAP ;
                  CAR ;
                  PAIR ;
                  DIP { DUP } ;
                  SWAP ;
                  CAR ;
                  SWAP ;
                  CDR ;
                  SWAP ;
                  PAIR ;
                  DIP { DUP } ;
                  SWAP ;
                  CAR ;
                  SWAP ;
                  CDR ;
                  SWAP ;
                  PAIR ;
                  DIP { DROP 2 } }
                { PUSH string "Burn : admin cannot vote" ; FAILWITH } ;
             DUP ;
             CAR ;
             DIP { DROP 9 } } ;
         NIL operation ;
         PAIR ;
         DIP { DROP 3 } } }
