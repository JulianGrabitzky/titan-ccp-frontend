<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Streams</h5>
      <div>
        <b-button v-b-toggle.collapse-stream variant="success" size="sm">Show Streams</b-button>
        <b-collapse id="collapse-stream" class="mt-2">
          <b-card>
            <b-table striped=" hover" :items="stream"></b-table>
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
      stream: null
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW STREAMS;"
    }).then(response => (this.stream = response.data[0].streams));
  }
};
</script>