<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Tables</h5>
      <div>
        <b-button v-b-toggle.collapse-table variant="success" size="sm">Show Tables</b-button>
        <b-collapse id="collapse-table" class="mt-2">
          <b-card>
            <b-table striped hover :items="table"></b-table>
          </b-card>
        </b-collapse>
      </div>
    </div>
  </div>
</template>

<script>
import { KSQL } from "../../http-common";

export default {
  data() {
    return {
      table: null
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW TABLES;"
    }).then(response => (this.table = response.data[0].tables));
  }
};
</script>