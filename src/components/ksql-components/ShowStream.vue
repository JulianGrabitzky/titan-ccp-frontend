<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Streams</h5>
      <div>
        <b-button v-b-toggle.collapse-stream variant="success" size="sm">Show Streams</b-button>
        <b-collapse id="collapse-stream" class="mt-2">
          <b-card>
            <b-table striped hover :items="stream" :fields="fields">
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
                  <b-card header="SQL">
                    <ul>{{ detailedStreamInfo.readQueries[0].queryString }}</ul>
                  </b-card>
                  <b-card header="Fields">
                    <ul v-for="info in detailedStreamInfo.fields" :key="info">{{ info }}</ul>
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
      fields: ["type", "name", "topic", "show_details"],
      stream: null,
      detailedStreamInfo: []
    };
  },

  mounted() {
    KSQL.post(`ksql`, {
      ksql: "SHOW STREAMS;"
    }).then(response => (this.stream = response.data[0].streams));
  },

  methods: {
    getDetailedData(streamName) {
      KSQL.post(`ksql`, {
        ksql: "DESCRIBE " + streamName + ";"
      }).then(
        response =>
          (this.detailedStreamInfo = response.data[0].sourceDescription)
      );
    }
  }
};
</script>