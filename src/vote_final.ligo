//*************************************************************//
// TEZOS PROJECT 3A IBC ESGI                                   //
// Developed By Lisa OULMI                                     //
// Version Bêta                                                //
// Copyright ©2020                                             //
//*************************************************************//

type ledger is map(address, string);

type storage is record
   voteofuser: ledger;
   owner: address;
   int_yes: int;
   int_no: int;
   contractPause: bool;
end

type action is
| Vote of string
| SetAdmin of address
| Pause of bool

//*************************************************************//
// Check si le sender est l'administrateur.
function isAdmin (const s : address) : bool is
  block {skip} with (sender = s)

//*************************************************************//
// Retourne l'état du contrat du storage.
function isPause (const s : storage) : bool is
  block{skip} with (s.contractPause)

//*************************************************************//
// Remise à zéro du contrat : effacer les votes + enlever la pause seulement par l'administrateur.
function setPause(const s : storage; const setter : bool) : storage is 
  block{
     if(isAdmin(s.owner))then
     block{
       s.contractPause := True;
       s.int_yes := 0;
       s.int_no := 0;
     }
     else failwith("You have to be admin to setPause")
  }with s

//*************************************************************//
// Modification de l'administrateur.
function setadm (const s : storage ; const addr : address) : storage is 
  block {
      if(isAdmin(s.owner)) then s.owner := addr;
      else failwith("Bad setadm");
   } with s

//*************************************************************//
// Vote : Tous les utilisateurs ont le droit de voter
// Un utilisateur doit pouvoir ne voter qu'une seule fois
// L'administrateur n'a pas le droit de voter
// Le smart contrat doit être mis en pause si 10 personnes ont voté.
// Quand le smart contract est mis en pause , le resultat du vote doit être calculé et stocké dans le storage.

function addVote (const s : storage; const v : string) : storage is 
  block{
   if(not(isAdmin(s.owner))) then
   block{
     const nb: nat = Map.size(s.voteofuser);
     if(nb = abs(10)) then
     block{
      var int_no: int := 0;
      var int_yes: int:= 0;
      for key->value in map s.voteofuser block{
        if(value = "yes") then{
          s.int_yes := int_yes + 1;
          int_yes := int_yes + 1;
          //failwith("test_yes")
        }
        else{
          //failwith("test_no")
          s.int_no := int_no + 1;
          int_no := int_no + 1;
        } // ferme else
      }// ferme for
    }// ferme block
    else {
        s.int_yes := 0;
        s.int_no := 0;
    }
  }
  else failwith("Burn : admin cannot vote");
  if(not(isAdmin(s.owner))) then
   block{
   if(isPause(s)) then
     block{
        s.voteofuser[sender] := v;
     }
   else s.contractPause := True;
   }
   else failwith("Burn : admin cannot vote");
 } with s


//**************************MAIN***********************************//

function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | Vote(n) -> addVote(s, n)
  | SetAdmin(a) -> setadm(s, a)
  | Pause(b) -> setPause(s, b)
  end)