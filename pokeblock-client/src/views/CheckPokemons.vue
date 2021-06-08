<template>
  <div>
    <div class="row text-center" style="margin-top: 10px;">
      <div class="col">
        <h2>Welcome {{ Account }}</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-6">
        <h4 class="text-muted">Here you can see your Pokemons</h4>
      </div>
      <div class="col-6 text-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#evolveModal">Evoluciona un Pokemon</button>
        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#fightModal">Pelea contra otro Entrenador!</button>
      </div>
    </div>
    <hr>
    <div v-if="Pokemons.length === 0" class="row">
      <div class="col">
        <button type="button" class="btn btn-primary" @click="getPokemons">Cargar Mis Pokemons</button>
      </div>
    </div>
    <div class="row" v-if="Pokemons.length > 0">
      <div v-for="pokemon in Pokemons" :key="pokemon.id" class="col d-flex justify-content-center">
        <PokemonHolder v-bind:pokemon="pokemon"></PokemonHolder>
      </div>
    </div>
    <div class="modal fade" id="evolveModal" tabindex="-1" aria-labelledby="evolveModalLabel" aria-hidden="true">
      <EvolvePokemon></EvolvePokemon>
    </div>
    <div class="modal fade" id="fightModal" tabindex="-1" aria-labelledby="fightModalLabel" aria-hidden="true">
      <FightTrainer v-bind:pokemons="Pokemons"></FightTrainer>
    </div>
  </div>
</template>

<script>
import web3 from "../other-data/web3";
import axios from "axios";
import Constants from "../other-data/Constants";
import PokemonHolder from "../components/PokemonHolder";
import Contract from "../other-data/Contract";
import EvolvePokemon from "../components/EvolvePokemon";
import FightTrainer from "../components/FightTrainer";


export default {
  name: "CheckPokemons",
  components: {
    PokemonHolder,
    EvolvePokemon,
    FightTrainer
  },
  data() {
    return {
      Account: '',
      PokeBlock: null,
      Pokemons: []
    }
  },
  methods: {
    async getAccount() {
      let accounts = await web3.eth.requestAccounts();
      this.Account = accounts[0];
    },
    getPokemonInfo(id, level, pokeblock_id) {
      axios.get(Constants.pokeApi + "/" + id)
          .then(response => {
            var pokemon = {
              "pokeblock_id": pokeblock_id,
              "name": response.data.name,
              "id": response.data.id,
              "img": response.data.sprites.front_default,
              "type": response.data.types[0].type.name,
              "level": level
            };
            this.Pokemons.push(pokemon);
          });
    },
    getPokemons() {
      this.PokeBlock.methods.getPokemons(this.Account).call({ from: this.Account})
          .then((response) => {
            response.forEach((poke) => {
              this.getPokemonInfo(poke.pokedex, poke.nivel, poke.id)
            });
          })
          .catch((error) => { console.log(error) });
    }
  },
  mounted() {
    this.getAccount();
    this.PokeBlock = new web3.eth.Contract(Contract.abi, Contract.address);
  }
}
</script>

<style scoped>
  button {
    margin-left: 5px;
    margin-right: 5px;
  }
</style>
