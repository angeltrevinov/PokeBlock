<template>
  <nav class="navbar navbar-dark bg-dark sticky-top" style="margin-bottom: 10px;">
    <div class="container-fluid">
      <a class="navbar-brand mb-0 h1" href="#">PokeBlock</a>
    </div>
  </nav>
  <CreateAccount></CreateAccount>
</template>

<script>
import CreateAccount from "./components/CreateAccout";

export default {
  name: 'App',
  components: {
    CreateAccount
  }
}
</script>

<style>
</style>
