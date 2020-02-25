<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Queries</h5>
      <div>
        <b-button v-b-toggle.collapse-query variant="success" size="sm">Show Queries</b-button>
        <b-collapse id="collapse-query" class="mt-2">
          <b-card>
            <b-table striped hover :items="query" :fields="fields">
              <template v-slot:cell(show_details)="row">
                <b-button
                  size="sm"
                  @click="getDetailedData(row.item.id); row.toggleDetails();"
                  class="mr-2"
                >{{ row.detailsShowing ? 'Hide' : 'Show'}} Details</b-button>
              </template>

              <template v-slot:row-details="row">
                <b-card class="mt-3">
                  <!--
                    These are the most imporant parts of the json object.
                    next step would be a more complex representation.
                  -->
                  <b-card header="SQL">
                    <ul>{{ detailedQueryInfo.statementText }}</ul>
                  </b-card>
                  <b-card header="Sources">
                    <ul v-for="source in detailedQueryInfo.sources" :key="source">{{ source }}</ul>
                  </b-card>
                  <b-card header="Sinks">
                    <ul v-for="sink in detailedQueryInfo.sinks" :key="sink">{{ sink }}</ul>
                  </b-card>
                  <b-card header="Fields">
                    <ul v-for="info in detailedQueryInfo.fields" :key="info">{{ info }}</ul>
                  </b-card>
                </b-card>
              </template>
            </b-table>
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
      fields: ["id", "show_details"],
      query: null,
      detailedQueryInfo: []
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW QUERIES;"
    }).then(response => (this.query = response.data[0].queries));
  },

  methods: {
    getDetailedData(queryName) {
      KSQL.post(`ksql`, {
        ksql: "Explain " + queryName + ";"
      }).then(
        response => (this.detailedQueryInfo = response.data[0].queryDescription)
      );
    }
  }
};
</script>