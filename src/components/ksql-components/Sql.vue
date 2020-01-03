<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Create,Drop or Terminate with SQL</h5>
      <div>
        <b-button v-b-toggle.collapse-sql variant="success" size="sm">Show SQL</b-button>
        <b-collapse id="collapse-sql" class="mt-2">
          <b-card>
            <b-container fluid>
              <b-row class="mb-4">
                <b-col sm="12">
                  <div>
                    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
                      <b-form-textarea
                        v-model="form.ksql"
                        required
                        placeholder="Enter SQL Statement"
                      ></b-form-textarea>
                      <b-button type="submit" variant="success">Go</b-button>
                      <b-button type="reset" variant="danger">Reset Form</b-button>
                    </b-form>
                  </div>
                  <b-card class="mt-3" header="Result">
                    <li v-for="info in result">{{ info }}</li>
                  </b-card>
                </b-col>
              </b-row>
            </b-container>
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
      result: null,
      form: {
        ksql: ""
      },
      show: true,
      totalRows: 100, // Set the total rows to the length of result
      currentPage: 1,
      perPage: 10,
      pageOptions: [5, 10, 15, 20]
    };
  },

  methods: {
    onSubmit(evt) {
      KSQL.post(`ksql`, this.form)
        .then(response => (this.result = response.data[0].commandStatus))
        .catch(error => (this.result = error.response));
    },
    onReset(evt) {
      // Reset our form values
      this.form.ksql = "";
      this.result = null;
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    }
  }
};
</script>