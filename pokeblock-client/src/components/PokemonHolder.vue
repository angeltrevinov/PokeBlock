<template>
  <div class="card" v-bind:class="color" style="width: 18rem; margin: 5px;">
    <img class="card-img-top" v-bind:src="pokemon.img" alt="Card image cap">
    <div class="card-body">
      <h5 class="card-title">{{ pokemon.name }}</h5>
      <h6 class="card-subtitle mb-2">{{ pokemon.type }}</h6>
    </div>
  </div>
</template>

<script>
export default {
  name: "PokemonHolder",
  data() {
    return {
      color: ''
    }
  },
  props: {
    pokemon: null
  },
  mounted() {
    if(this.pokemon.id>= 1 && this.pokemon.id <= 3) {
      this.color = 'text-white bg-success';
    } else if (this.pokemon.id >= 4 && this.pokemon.id <= 6) {
      this.color = 'text-white bg-danger';
    } else if (this.pokemon.id >= 7 && this.pokemon.id <= 9) {
      this.color = 'text-white bg-info';
    }
  }
}
</script>

<style scoped>

</style>
