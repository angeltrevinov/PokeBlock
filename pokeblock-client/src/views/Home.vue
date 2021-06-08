<template>
  <div class="home">
    <div class="row">
      <div class="col-6">
        <img src="../assets/pokemon-face.jpg" style="width: 100%; height: 100%;">
      </div>
      <div class="col-6 text-center align-items-center">
        <h2 class="align-middle">Bienvenido a PokeBlock!</h2>
        <h4 class="text-muted align-middle">Aqui puedes coleccionar Pokemons, evolucionarlos y pelear contra tus amigos</h4>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Home',
}
</script>

<style>
.home {
  height: 94vh;
  padding: 0px;
  margin: 0px;
}

.row {
  height: 100%;
  width: 100%;
  padding: 0px;
  margin: 0px;
}

.col-6 {
  padding: 0px;
  height: 100%;
}
</style>
