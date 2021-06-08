<template>
  <div>
    <div class="row text-center" style="margin-top: 10px;">
      <div class="col">
        <h2>Welcome {{ Account }}</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-8">
        <h4 class="text-muted">Here you can see your Pokemons</h4>
      </div>
      <div class="col-4 text-end">
        <button type="button" class="btn btn-primary">Evolve a Pokemon</button>
        <button type="button" class="btn btn-danger">Fight Another Trainer!</button>
      </div>
    </div>
    <hr>
    <div class="row">
      <div v-for="pokemon in Pokemons" :key="pokemon.id" class="col d-flex justify-content-center">
        <PokemonHolder v-bind:pokemon="pokemon"></PokemonHolder>
      </div>
    </div>
  </div>
</template>

<script>
import web3 from "../other-data/web3";
import axios from "axios";
import Constants from "../other-data/Constants";
import PokemonHolder from "../components/PokemonHolder";


export default {
  name: "CheckPokemons",
  components: {
    PokemonHolder
  },
  data() {
    return {
      Account: '',
      Pokemons: []
    }
  },
  methods: {
    async getAccount() {
      let accounts = await web3.eth.requestAccounts();
      this.Account = accounts[0];
    },
    getPokemonInfo(id) {
      axios.get(Constants.pokeApi + "/" + id)
          .then(response => {
            var pokemon = {
              "name": response.data.name,
              "id": response.data.id,
              "img": response.data.sprites.front_default,
              "type": response.data.types[0].type.name
            };
            this.Pokemons.push(pokemon);
          });
    }
  },
  mounted() {
    let pokeId = [
        Constants.Bulbasaur,
        Constants.Squirtle,
        Constants.Charmander,
        Constants.Blastoise,
        Constants.Charizard,
        Constants.Charmeleon,
        Constants.Ivysaur,
        Constants.Venusaur,
        Constants.Wartortle
    ];
    this.getAccount();
    pokeId.forEach(poke => {
      this.getPokemonInfo(poke)
    });
  }
}
</script>

<style scoped>
  button {
    margin-left: 5px;
    margin-right: 5px;
  }
</style>
