<template>
  <nav class="navbar navbar-dark navbar-expand-md bg-dark sticky-top" style="margin-bottom: 10px;">
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
        </ul>
      </div>

    </div>
  </nav>

  <router-view/>

</template>

<style>
</style>
