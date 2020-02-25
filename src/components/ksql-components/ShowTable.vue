<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Tables</h5>
      <div>
        <b-button v-b-toggle.collapse-table variant="success" size="sm">Show Tables</b-button>
        <b-collapse id="collapse-table" class="mt-2">
          <b-card>
            <b-table striped hover :items="table" :fields="fields">
              <template v-slot:cell(show_details)="row">
                <b-button
                  size="sm"
                  @click="getDetailedData(row.item.name); row.toggleDetails();"
                  class="mr-2"
                >{{ row.detailsShowing ? 'Hide' : 'Show'}} Details</b-button>
              </template>

              <template v-slot:row-details="row">
                <b-card class="mt-3">
                  <!--
                    These are the most imporant parts of the json object.
                    next step would be a more complex representation.
                  -->
                  <li v-for="info in detailedTableInfo.fields" :key="info">{{ info }}</li>
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
      fields: ["type", "name", "isWindowed", "show_details"],
      table: null,
      detailedTableInfo: []
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW TABLES;"
    }).then(response => (this.table = response.data[0].tables));
  },

  methods: {
    getDetailedData(tableName) {
      KSQL.post(`ksql`, {
        ksql: "DESCRIBE " + tableName + ";"
      }).then(
        response =>
          (this.detailedTableInfo = response.data[0].sourceDescription)
      );
    }
  }
};
</script>