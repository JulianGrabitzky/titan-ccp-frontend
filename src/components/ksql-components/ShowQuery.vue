<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Queries</h5>
      <div>
        <b-button v-b-toggle.collapse-query variant="success" size="sm">Show Queries</b-button>
        <b-collapse id="collapse-query" class="mt-2">
          <b-card>
            <b-table striped=" hover" :items="topic"></b-table>
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
      query: null
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW QUERIES;"
    }).then(response => (this.query = response.data[0].queries));
  }
};
</script>