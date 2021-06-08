<template>
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Que Pokemon Quieres Conseguir?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div v-for="pokemon in pokemons"  class="col d-flex justify-content-center" :key="pokemon.id">
            <PokemonHolder v-bind:pokemon="pokemon" @click="evolvePokemon(pokemon)"></PokemonHolder>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Constants from "../other-data/Constants";
import PokemonHolder from "./PokemonHolder";
import web3 from "../other-data/web3";
import Contract from "../other-data/Contract";

export default {
  name: "EvolvePokemon",
  components: {
    PokemonHolder
  },
  data() {
    return {
      pokemons: [],
      PokeBlock: null,
      Account: null
    }
  },
  methods: {
    async getAccount() {
      let accounts = await web3.eth.requestAccounts();
      this.Account = accounts[0];
    },
    getPokemon(id) {
      axios.get(Constants.pokeApi + "/" + id)
          .then(response => {
            var pokemon = {
              "name": response.data.name,
              "id": response.data.id,
              "img": response.data.sprites.front_default,
              "type": response.data.types[0].type.name,
              "level": 0
            };
            this.pokemons.push(pokemon);
          });
    },
    evolvePokemon(pokemon) {
      var random;
      if (
          pokemon.id === Constants.Ivysaur ||
          pokemon.id === Constants.Charmeleon ||
          pokemon.id === Constants.Wartortle
      ) {
        random = parseInt(Math.random() * (20 - 11) + 11);
      } else if (
          pokemon.id === Constants.Venusaur ||
          pokemon.id === Constants.Charizard ||
          pokemon.id === Constants.Blastoise
      ) {
        random = parseInt(Math.random() * (30 - 21) + 21);
      }
      this.PokeBlock.methods.evolvePokemon(
          this.Account,
          pokemon.id,
          random,
          pokemon.type
      ).send({ from: this.Account})
          .then((response) => { console.log(response)})
          .catch((error) => { console.log(error)});
    }
  },
  mounted() {
    this.getAccount();
    this.PokeBlock = new web3.eth.Contract(Contract.abi, Contract.address);
    this.getPokemon(Constants.Ivysaur);
    this.getPokemon(Constants.Venusaur);
    this.getPokemon(Constants.Charmeleon);
    this.getPokemon(Constants.Charizard);
    this.getPokemon(Constants.Wartortle);
    this.getPokemon(Constants.Blastoise);
  }
}
</script>

<style scoped>

</style>
