<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Topics</h5>
      <div>
        <b-button v-b-toggle.collapse-topic variant="success" size="sm">Show Topics</b-button>
        <b-collapse id="collapse-topic" class="mt-2">
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
      topic: null
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW TOPICS;"
    }).then(response => (this.topic = response.data[0].topics));
  }
};
</script>