pragma solidity ^0.7.0;
pragma abicoder v2;

import "./erc721.sol";

/*

# TODO: Pokemon with starters for the first gen, that you can transfer with other users.
            Each pokemn can evolve if you have n of the previous gen on your contract.
            You can also battle (the one with a lot of monsters wins, if it wins, gives one random starter)

# TODO:    El contrato fue deployeado a una testnet.    5
# TODO:    Utiliza correctamente los tipos de variables para cada caso de uso.    10
# TODO:    Implementa eventos.    10
# TODO:    Uso correcto de modificadores de funciones.    10
# TODO:    Uso correcto de asserts, require, reverts.    10
# TODO:    Uso correcto de visibilidad de funciones.    10
# TODO:    Implementa un librería externa/hereda un contrato.    10
# TODO:    El código es limpio.    10
# TODO:    El smart contract utiliza gas de forma óptima.    10
# TODO:    Implementa su propio token.    10
# TODO:    Tiene unit testing básico.    10
# TODO:    Implementa una estructura de proyecto con Truffle.    5
# TODO:    Implementa criterios de seguridad básicos.    10
# TODO:    Utiliza un feed de datos descentralizado (oracle).    10
*/

contract PokeBlock is ERC721{
    
    //-------------- EVENTS --------------
    event NewPokemon(uint id, uint8 pokedex, uint8 nivel, string tipo, address trainer);
    event NewTrainer(string name, address id);
    event BattleWinner(address idTrainer);

    //-------------- STRUCTS --------------
    struct Pokemon {
        uint id;
        uint8 pokedex;
        uint8 nivel;
        string tipo;
    }
    
    struct Trainer {
        string name;
        Pokemon[] pokemons;
    }
    
    // -------------- GLOBAL VARIABLES --------------
    uint idCount;
    address [] stackTrainers;
    mapping (address => Trainer) trainers;
    
    //-------------- MODIFIERS --------------
    
    // Checks if trainer exists 
    modifier trainerExists(address _trainer){
        bool found = false;
        for(uint i = 0; i < stackTrainers.length; i++){
            if(stackTrainers[i] ==_trainer){
                found = true;
            }
        }
        require(found == true, "This trainer doesn't exists");
        _;
    }
    
    // Checks if trainer doesn't exists 
    modifier trainerNotExists(address _trainer){
        bool found = false;
        for(uint i = 0; i < stackTrainers.length; i++){
            if(stackTrainers[i] == _trainer){
                found = true;
            }
        }
        require(found == false, "This trainer already exists");
        _;
    }
    
    // Verify that both trainers have the pokemon to battle
    modifier trainerHasPokemonToBattle(uint _pokeId, address _trainerId){
        bool found = false;
        
        for(uint i = 0; i < trainers[_trainerId].pokemons.length; i++){
            if(trainers[_trainerId].pokemons[i].id == _pokeId){
                found = true;
            }
        }
        
        require(found == true , "One of the trainers doesn't have the pokemon selected to battle");
        _;
    }
    
    //-------------- FUNCTIONS --------------
    
    // Creates a new trainer
    function createTrainer(string memory _name, address _id) public trainerNotExists(_id) {
        Trainer storage trainer = trainers[_id];
        trainer.name = _name;
        stackTrainers.push(_id);
        emit NewTrainer(_name, _id);
    }
    
    // Adds a Pokemon to a trainer 
    function createPokemon(uint8 _pokedex, uint8 _nivel, string memory _tipo, address _trainer) public trainerExists(_trainer){
        trainers[_trainer].pokemons.push(Pokemon(idCount, _pokedex, _nivel, _tipo));
        stackTrainers.push(_trainer);
        emit NewPokemon(idCount, _pokedex, _nivel, _tipo, _trainer);
        idCount++;
    }
    
    function _getPokes(address _trainer, uint _pokeId) private trainerExists(_trainer) trainerHasPokemonToBattle(_pokeId, _trainer) returns(Pokemon memory) {
        Pokemon memory pokemon;

        for(uint i = 0; i < trainers[_trainer].pokemons.length; i++){
            if(trainers[_trainer].pokemons[i].id == _pokeId){
                pokemon = Pokemon(0, trainers[_trainer].pokemons[i].pokedex, trainers[_trainer].pokemons[i].nivel, trainers[_trainer].pokemons[i].tipo);
            }
        }
        
        return pokemon;
    }
    
    // Simulates battle
    function battle(uint _pokeIdA, uint _pokeIdB, address _trainerIdA, address _trainerIdB) public {
        Pokemon memory pokemonA;
        Pokemon memory pokemonB;
        
        pokemonA = _getPokes(_trainerIdA, _pokeIdA);
        pokemonB = _getPokes(_trainerIdB, _pokeIdB);
        
        if(pokemonA.nivel > pokemonB.nivel){
            createPokemon(pokemonB.pokedex, pokemonB.nivel, pokemonB.tipo, _trainerIdA);
            emit BattleWinner(_trainerIdA);
        }
        else if(pokemonB.nivel > pokemonA.nivel){
            createPokemon(pokemonA.pokedex, pokemonA.nivel, pokemonA.tipo, _trainerIdB);
            emit BattleWinner(_trainerIdB);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("fire"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("grass")))){
            createPokemon(pokemonB.pokedex, pokemonB.nivel, pokemonB.tipo, _trainerIdA);
            emit BattleWinner(_trainerIdA);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("fire"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("water")))){
            createPokemon(pokemonA.pokedex, pokemonA.nivel, pokemonA.tipo, _trainerIdB);
            emit BattleWinner(_trainerIdB);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("fire"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("fire")))){
            emit BattleWinner(0x0000000000000000000000000000000000000000);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("water"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("grass")))){
            createPokemon(pokemonA.pokedex, pokemonA.nivel, pokemonA.tipo, _trainerIdB);
            emit BattleWinner(_trainerIdB);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("water"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("fire")))){
            createPokemon(pokemonB.pokedex, pokemonB.nivel, pokemonB.tipo, _trainerIdA);
            emit BattleWinner(_trainerIdA);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("water"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("water")))){
            emit BattleWinner(0x0000000000000000000000000000000000000000);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("grass"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("grass")))){
            emit BattleWinner(0x0000000000000000000000000000000000000000);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("grass"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("water")))){
            createPokemon(pokemonB.pokedex, pokemonB.nivel, pokemonB.tipo, _trainerIdA);
            emit BattleWinner(_trainerIdA);
        }
        else if(keccak256(bytes((pokemonA.tipo))) == keccak256(bytes(("grass"))) && keccak256(bytes((pokemonB.tipo))) == keccak256(bytes(("fire")))){
            createPokemon(pokemonA.pokedex, pokemonA.nivel, pokemonA.tipo, _trainerIdB);
            emit BattleWinner(_trainerIdB);
        }
        
    }
    
    // checks how many pokemons a trainer has 
    function balanceOf(address _owner) override external view returns (uint256) {
        return trainers[_owner].pokemons.length;
    }
    
    function _transfer(address _from, address _to, uint256 _tokenId) private trainerHasPokemonToBattle(_tokenId, _from){
        Pokemon memory pokemon;
        
        for(uint i = 0; i < trainers[_from].pokemons.length; i++){
            if(trainers[_from].pokemons[i].id == _tokenId){
                pokemon = Pokemon(trainers[_from].pokemons[i].id, trainers[_from].pokemons[i].pokedex, trainers[_from].pokemons[i].nivel, trainers[_from].pokemons[i].tipo);
                trainers[_from].pokemons[i] = trainers[_from].pokemons[trainers[_from].pokemons.length - 1];
                delete trainers[_from].pokemons[trainers[_from].pokemons.length - 1];
                trainers[_from].pokemons.pop();
            }
        }
        
        trainers[_to].pokemons.push(pokemon);
    }
    
    function transferFrom(address _from, address _to, uint256 _tokenId) override external payable {
        require(_from != _to, "Address to transfer has to be different");
        _transfer(_from, _to, _tokenId);
    }
    
    //Function to evolve a pokemon, given the pokedex number
    function evolvePokemon(address _trainerId, uint8 _pokedex, uint8 _nivel, string memory _tipo) public trainerExists(_trainerId){
        _erasePokemons(_trainerId, _pokedex);
        createPokemon(_pokedex, _nivel, _tipo, _trainerId);
    }
    
    function _erasePokemons(address _trainerId, uint8 _pokedex) private {
        uint pokeCount;
        uint[] memory pokesIndex = new uint[](3);
        
        for(uint i = 0; i < trainers[_trainerId].pokemons.length; i++){
            if(trainers[_trainerId].pokemons[i].pokedex == _pokedex-1){
                pokesIndex[pokeCount] = i;
                pokeCount++;
            }
            if(pokeCount >= 3){
                break;
            }
        }
        
        require(pokeCount >= 3, "You don't have enough pokemons to evolve");
        
        trainers[_trainerId].pokemons[pokesIndex[0]] = trainers[_trainerId].pokemons[trainers[_trainerId].pokemons.length - 1];
        trainers[_trainerId].pokemons[pokesIndex[1]] = trainers[_trainerId].pokemons[trainers[_trainerId].pokemons.length - 2];
        trainers[_trainerId].pokemons[pokesIndex[2]] = trainers[_trainerId].pokemons[trainers[_trainerId].pokemons.length - 3];
        trainers[_trainerId].pokemons.pop();
        trainers[_trainerId].pokemons.pop();
        trainers[_trainerId].pokemons.pop();
    }
    
    // Function to obtain all pokemons from a trainer
    function getPokemons(address _trainerId) public view trainerExists(_trainerId) returns(Pokemon[] memory){
        return trainers[_trainerId].pokemons;
    }
    
}