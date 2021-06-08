<template>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pelea contra otro Entrenador</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row" v-if="!userFound">
          <div class="col-8">
            <input type="text" class="form-control" placeholder="Escribe el Address del usuario" v-model="userSelected">
          </div>
          <div class="col-4">
            <button type="button" class="btn btn-primary" @click="buscarUsuario">Buscar</button>
          </div>
        </div>
        <table class="table" v-if="userFound">
          <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Level</th>
            <th scope="col">Type</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="pokemon in pokemons" :key="pokemon.pokeblock_id" @click="empezarPelea(pokemon)">
            <th scope="row">{{pokemon.pokeblock_id }}</th>
            <td>{{ pokemon.name }}</td>
            <td>{{ pokemon.level }}</td>
            <td>{{ pokemon.type }}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import web3 from "../other-data/web3";
import Contract from "../other-data/Contract";

export default {
  name: "FightTrainer",
  props: {
    pokemons: null
  },
  data() {
    return {
      Account: '',
      PokeBlock: null,
      userFound: false,
      userSelected: '',
      randomOpponet: null
    }
  },
  methods: {
    async getAccount() {
      let accounts = await web3.eth.requestAccounts();
      this.Account = accounts[0];
    },
    buscarUsuario() {
      this.PokeBlock.methods.getPokemons(this.userSelected).call({ from: this.Account })
          .then((response) => {
            console.log(response);
            var max = response.length;
            var index = parseInt(Math.random() * (max - 0) + 0);
            this.randomOpponet = response[index].id
            console.log(this.randomOpponet)
            this.userFound = true;
          })
          .catch((error) => { console.log(error)});
    },
    empezarPelea(pokemon) {
      console.log(this.randomOpponet);
      console.log(pokemon);
      this.PokeBlock.methods.battle(
          pokemon.pokeblock_id,
          this.randomOpponet,
          this.Account,
          this.userSelected
      ).send({ from: this.Account })
          .then(response => {
            let winner = response.events.BattleWinner.returnValues.idTrainer;
            if (winner === '0x0000000000000000000000000000000000000000') {
              alert("EMPATE");
            } else if (winner === this.Account) {
              alert("GANASTE!!!!!");
            } else if (winner !== this.Account) {
              alert("PERDISTE :C");
            }
          })
          .catch(error => {console.log(error)});
    }
  },
  mounted() {
    this.getAccount();
    this.PokeBlock = new web3.eth.Contract(Contract.abi, Contract.address);
  },

}
</script>

<style scoped>

</style>
