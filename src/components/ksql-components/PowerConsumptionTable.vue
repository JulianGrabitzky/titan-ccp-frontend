<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Average powerconsumption saturday night</h5>
      <div>
        <b-card class="mt-3">
          <!--
                    These are the most imporant parts of the json object.
                    next step would be a more complex representation.
          -->
          <li v-for="info in table" :key="info">{{ info }}</li>
        </b-card>
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
    KSQL.post(`query`, {
      ksql:
        "SELECT window_start, avg_power FROM AVG_POWER_SATURDAY_0_TO_6 LIMIT 1;",
      streamsProperties: {
        "ksql.streams.auto.offset.reset": "earliest"
      }
    })
      .then(
        response =>
          (this.table = ([response.data] + "").split()[0].match(/\[(.*?)\]/g))
      )
      .catch(error => console.log(error.response));
  }
};
</script>