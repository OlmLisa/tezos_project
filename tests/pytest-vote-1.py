#*************************************************************#
# TEZOS PROJECT 3A IBC ESGI                                   #
# Developed By Lisa OULMI                                     #
# Version Bêta                                                #
# Copyright ©2020                                             #
#*************************************************************#

from os.path import dirname, join
from unittest import TestCase
from pytezos import ContractInterface

# run this test with :
# pytest token_test.py

#*******************************************************************************************************************************************************************************#

class VoteContractTest(TestCase):

    @classmethod
    def setUpClass(cls):
        project_dir = dirname(dirname(__file__))
        print("projectdir", project_dir)
        cls.vote = ContractInterface.create_from(join(project_dir, 'src/vote_final.tz'))

    def test_set_admin(self):
        root = "tz1VphG4Lgp39MfQ9rTUnsm7BBWyXeXnJSMZ"
        alice = "tz1ibMpWS6n6MJn73nQHtK5f4ogyYC1z9T9z"
        result = self.vote.setAdmin(
            root
        ).result(
           storage={
           "voteofuser": {  },
           "owner": alice,
           "int_yes": 0,
           "int_no": 0,
           "contractPause": False,
            },
            source=alice
        )
        self.assertEqual(root, result.storage['owner'])

    def test_pause(self):
        root = "tz1VphG4Lgp39MfQ9rTUnsm7BBWyXeXnJSMZ"
        status = True
        result = self.vote.pause(
            status
        ).result(
            storage={
           "voteofuser": {  },
           "owner": root,
           "int_yes": 0,
           "int_no": 0,
           "contractPause": False,
            },
            source=root
        )
        self.assertEqual(status, result.storage['contractPause'])

    def test_vote(self):
        Bob = "tz1T7dafhrN3hi7LCvYKzD7ZbZczeAdCC7z5"
        root = "tz1VphG4Lgp39MfQ9rTUnsm7BBWyXeXnJSMZ"
        Alice = "tz1N5sFGe9mhQWgDPsTLU1tDFmFZ39MTsync"
        alicevote = "yes"
        result = self.vote.vote(
            alicevote
        ).result(
            storage={
           "voteofuser": { Bob: "yes" },
           "owner": root,
           "int_yes": 0,
           "int_no": 0,
           "contractPause": False,
            },
            source=Alice
        )
        self.assertEqual(0, result.storage['int_no'])
        self.assertEqual(0, result.storage['int_yes'])
        self.assertEqual("yes", result.storage['voteofuser'][Bob])
        self.assertEqual("yes", result.storage['voteofuser'][Alice])

