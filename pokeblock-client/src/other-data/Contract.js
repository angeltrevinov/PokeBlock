const address = '0xDdFAEf223C57844E9F86E278e2A4DCce2f5E4763' // The Contract Address
const abi = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_pokeIdA",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_pokeIdB",
                "type": "uint256"
            },
            {
                "internalType": "address",
                "name": "_trainerIdA",
                "type": "address"
            },
            {
                "internalType": "address",
                "name": "_trainerIdB",
                "type": "address"
            }
        ],
        "name": "battle",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address",
                "name": "idTrainer",
                "type": "address"
            }
        ],
        "name": "BattleWinner",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "uint8",
                "name": "_pokedex",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "_nivel",
                "type": "uint8"
            },
            {
                "internalType": "string",
                "name": "_tipo",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "_trainer",
                "type": "address"
            }
        ],
        "name": "createPokemon",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_name",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "_id",
                "type": "address"
            }
        ],
        "name": "createTrainer",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_trainerId",
                "type": "address"
            },
            {
                "internalType": "uint8",
                "name": "_pokedex",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "_nivel",
                "type": "uint8"
            },
            {
                "internalType": "string",
                "name": "_tipo",
                "type": "string"
            }
        ],
        "name": "evolvePokemon",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "id",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint8",
                "name": "pokedex",
                "type": "uint8"
            },
            {
                "indexed": false,
                "internalType": "uint8",
                "name": "nivel",
                "type": "uint8"
            },
            {
                "indexed": false,
                "internalType": "string",
                "name": "tipo",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "address",
                "name": "trainer",
                "type": "address"
            }
        ],
        "name": "NewPokemon",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "name",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "address",
                "name": "id",
                "type": "address"
            }
        ],
        "name": "NewTrainer",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "_from",
                "type": "address"
            },
            {
                "indexed": true,
                "internalType": "address",
                "name": "_to",
                "type": "address"
            },
            {
                "indexed": true,
                "internalType": "uint256",
                "name": "_tokenId",
                "type": "uint256"
            }
        ],
        "name": "Transfer",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_from",
                "type": "address"
            },
            {
                "internalType": "address",
                "name": "_to",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "_tokenId",
                "type": "uint256"
            }
        ],
        "name": "transferFrom",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_owner",
                "type": "address"
            }
        ],
        "name": "balanceOf",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_trainerId",
                "type": "address"
            }
        ],
        "name": "getPokemons",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "id",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint8",
                        "name": "pokedex",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "nivel",
                        "type": "uint8"
                    },
                    {
                        "internalType": "string",
                        "name": "tipo",
                        "type": "string"
                    }
                ],
                "internalType": "struct PokeBlock.Pokemon[]",
                "name": "",
                "type": "tuple[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
]; // the ABI

export default {
    address,
    abi
};
