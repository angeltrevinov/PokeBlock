<template>
  <nav class="navbar navbar-dark navbar-expand-md bg-dark sticky-top">
    <div class="container-fluid">

      <a class="navbar-brand mb-0 h1" href="#">PokeBlock</a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <router-link class="nav-link" aria-current="page" to="/">Home</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/create-account">Create Account</router-link>
          </li>
          <li class="nav-item">
            <button v-if="Account === ''" type="button" class="btn btn-light" @click="connectMetaMask">Connect with MetaMask</button>
            <span class="nav-link mb-0 h6" v-else-if="Account !== ''">Account: {{ Account }}</span>
          </li>
        </ul>
      </div>

    </div>
  </nav>

  <router-view/>

</template>

<script>
import web3 from "./other-data/web3";

export default {
  name: 'App',
  data() {
    return {
      Account: ''
    }
  },
  methods: {
    async connectMetaMask() {
      let accounts = await web3.eth.requestAccounts(response => {
        if (response !== null && response.code == 4001) {
          alert("You need to accept MetaMask to use this page");
        }
      });
      this.Account = accounts[0];
    }
  }
}

</script>

<style>
</style>
