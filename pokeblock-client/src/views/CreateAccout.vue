<template>
  <div class="container-fluid">
    <div v-if="!created" class="row">
      <div class="col text-center">
        <h3>Vuelvete un entrenador!</h3>
      </div>
    </div>
    <div v-if="!created" class="row" style="margin-top: 10px;">
      <div class="col-8">
        <input type="text" class="form-control" placeholder="Escribe tu nombre" v-model="name">
      </div>
      <div class="col-3">
        <button type="button" class="btn btn-primary" @click="createAccount">Create Account</button>
      </div>
    </div>
    <div v-if="created" class="row">
      <div class="col text-center">
        <h3>Escoge a Tu Pokemon inicial!</h3>
      </div>
    </div>
    <div v-if="created" class="row">
      <div v-for="pokemon in starters" :key="pokemon.id" class="col d-flex justify-content-center">
        <PokemonHolder v-bind:pokemon="pokemon" @click="chooseStarter(pokemon)"></PokemonHolder>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Constants from "../other-data/Constants";
import PokemonHolder from "../components/PokemonHolder";
import web3 from "../other-data/web3";
import Contract from "../other-data/Contract";

export default {
  name: "CreateAccount",
  components: {
    PokemonHolder
  },
  data() {
    return {
      starters: [],
      name: '',
      Account: '',
      PokeBlock: null,
      created: false,

    }
  },
  mounted() {
    this.getAccount();
    this.getPokemonStarters(Constants.Bulbasaur);
    this.getPokemonStarters(Constants.Charmander);
    this.getPokemonStarters(Constants.Squirtle);
  },
  methods: {
    async getAccount() {
      let accounts = await web3.eth.requestAccounts();
      this.Account = accounts[0];
      this.PokeBlock = new web3.eth.Contract(Contract.abi, Contract.address);
    },
    getPokemonStarters(id) {
      axios.get(Constants.pokeApi + "/" + id)
          .then(response => {
            var pokemon = {
              "name": response.data.name,
              "id": response.data.id,
              "img": response.data.sprites.front_default,
              "type": response.data.types[0].type.name,
              "level": 0
            };
            this.starters.push(pokemon);
          });
    },
    createAccount() {
      this.PokeBlock.methods.createTrainer(this.name, this.Account).send({ from: this.Account})
          .then((response) => {
            this.created = true;
            console.log(response)
          })
          .catch((error) => {
            this.created = true;
            console.log(error)
          });
    },
    chooseStarter(pokemon) {
      var random = parseInt(Math.random() * (10 - 1) + 1);
      this.PokeBlock.methods.createPokemon(
          pokemon.id,
          random,
          pokemon.type,
          this.Account
      ).send({ from: this.Account})
          .then((response) => { console.log(response)})
          .catch((error) => {console.log(error)});
    }
  }
}
</script>

<style scoped>

</style>
