<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col text-center">
        <h3>Escoge a Tu Pokemon inicial!</h3>
      </div>
    </div>
    <div class="row">
      <div v-for="pokemon in starters" :key="pokemon.id" class="col d-flex justify-content-center">
        <PokemonHolder v-bind:pokemon="pokemon"></PokemonHolder>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Constants from "../Constants";
import PokemonHolder from "../components/PokemonHolder";

export default {
  name: "CreateAccount",
  components: {
    PokemonHolder
  },
  data() {
    return {
      starters: []
    }
  },
  mounted() {
    this.getPokemonStarters(Constants.Bulbasaur);
    this.getPokemonStarters(Constants.Charmander);
    this.getPokemonStarters(Constants.Squirtle);
  },
  methods: {
    getPokemonStarters(id) {
      axios.get(Constants.pokeApi + "/" + id)
          .then(response => {
            var pokemon = {
              "name": response.data.name,
              "id": response.data.id,
              "img": response.data.sprites.front_default,
              "type": response.data.types[0].type.name
            };
            this.starters.push(pokemon);
          });
    }
  }
}
</script>

<style scoped>

</style>
