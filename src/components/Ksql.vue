<template>
  <div>
    <b-container>
      <b-row class="mb-4">
        <b-col>
          <show-topic></show-topic>
        </b-col>
      </b-row>
      <b-row class="mb-4">
        <b-col>
          <show-stream></show-stream>
        </b-col>
      </b-row>
      <b-row class="mb-4">
        <b-col>
          <show-table></show-table>
        </b-col>
      </b-row>
      <b-row class="mb-4">
        <b-col>
          <show-query></show-query>
        </b-col>
      </b-row>
      <b-row class="mb-4">
        <b-col>
          <sql></sql>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script lang="ts">
import { Vue, Component, Prop, Watch } from "vue-property-decorator";

import BootstrapVue from "bootstrap-vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

import ColorRepository from "../ColorRepository";
import ShowTopic from "./ksql-components/ShowTopic.vue";
import ShowStream from "./ksql-components/ShowStream.vue";
import ShowTable from "./ksql-components/ShowTable.vue";
import ShowQuery from "./ksql-components/ShowQuery.vue";
import Sql from "./ksql-components/Sql.vue";

@Component({
  components: {
    ShowTopic,
    ShowStream,
    ShowTable,
    ShowQuery,
    Sql
  }
})
export default class Ksql extends Vue {}
</script>

