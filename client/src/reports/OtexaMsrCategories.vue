<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">

          <div class="filter-field" v-if="source==='ANNUAL'">
            <label for="categoryNotions">Notions:</label>
            <select
              v-model="selectedCategories"
              name="categoryNotions"
              id="categoryNotions"
              size="20"
            >
              <option
                v-for="item in categoryNotions"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='ANNUAL'">
            <label for="categoryYarn">Yarn:</label>
            <select
              v-model="selectedCategories"
              name="categoryYarn"
              id="categoryYarn"
              size="20"
            >
              <option
                v-for="item in categoryYarn"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='ANNUAL'">
            <label for="categoryFabric">Fabrics:</label>
            <select
              v-model="selectedCategories"
              name="categoryFabric"
              id="categoryFabric"
              size="20"
            >
              <option
                v-for="item in categoryFabric"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='ANNUAL'">
            <label for="categoryApparel">Apparel:</label>
            <select
              v-model="selectedCategories"
              name="categoryApparel"
              id="categoryApparel"
              size="20"
            >
              <option
                v-for="item in categoryApparel"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='ANNUAL'">
            <label for="categoryMadeUps">Made Ups:</label>
            <select
              v-model="selectedCategories"
              name="categoryMadeUps"
              id="categoryMadeUps"
              size="20"
            >
              <option
                v-for="item in categoryMadeUps"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>

          <div class="filter-field" v-if="source==='EXPORT'">
            <label for="groupAggregates">Aggregates:</label>
            <select
              v-model="selectedGroups"
              name="groupAggregates"
              id="groupAggregates"
              size="20"
            >
              <option
                v-for="item in groupAggregates"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='EXPORT'">
            <label for="groupApparel">Apparel:</label>
            <select
              v-model="selectedGroups"
              name="groupApparel"
              id="groupApparel"
              size="20"
            >
              <option
                v-for="item in groupApparel"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='EXPORT'">
            <label for="groupYarn">Yarn:</label>
            <select
              v-model="selectedGroups"
              name="groupYarn"
              id="groupYarn"
              size="20"
            >
              <option
                v-for="item in groupYarn"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='EXPORT'">
            <label for="groupFabric">Fabrics:</label>
            <select
              v-model="selectedGroups"
              name="groupFabric"
              id="groupFabric"
              size="20"
            >
              <option
                v-for="item in groupFabric"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="source==='EXPORT'">
            <label for="groupMadeUps">Made Ups:</label>
            <select
              v-model="selectedGroups"
              name="groupMadeUps"
              id="groupMadeUps"
              size="20"
            >
              <option
                v-for="item in groupMadeUps"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="reportName.includes('Export')">
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="2"
            >
              <option value='DOLLARS'>DOLLARS</option>
              <option value='UNITS'>UNITS</option>
            </select>
          </div>
          <div class="filter-field" v-else>
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="3"
            >
              <option value='DOLLARS'>DOLLARS</option>
              <option value='SME'>SME</option>
              <option value='UNITS'>UNITS</option>
            </select>
          </div>
        </div>

        <div class="filter-buttons">
          <button @click="viewReport()" id="submit-button">Submit</button>
          <button @click="reset()" id="reset-button">Reset</button>
        </div>
      </div>
    </div>
    <div :class="getReportClass()">
      <toolbar :loadingReport="loadingReport" :pbi="pbi">
        <button @click="isReportVisible = false">
          <img src="/images/back-arrow.svg" />
        </button>
      </toolbar>
      <div id="embed-container" ref="embed-container"></div>
    </div>
  </div>
</template>
<script>
import Toolbar from '@/Toolbar'
import TokenExpirationListenerMixin from '../TokenExpirationListenerMixin'
export default {
  name: 'OtexaMsrCategories',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    categoryNotions: [],
    categoryYarn: [],
    groupYarn: [],
    categoryFabric: [],
    groupFabric: [],
    categoryApparel: [],
    groupAggregates: [],
    groupApparel: [],
    categoryMadeUps: [],
    groupMadeUps: [],
    allCategories: [],
    allGroups: [],
    selectedCategories: [],
    selectedGroups: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
    source: 'ANNUAL'
  }),
  async created () {
    this.source = this.reportName.includes('Export')
      ? 'EXPORT'
      : 'ANNUAL'
    const MSR_CATEGORIES = {
      'categoryNotions': [0, 1, 2, 11, 12, 14, 30, 31, 32, 40, 41, 42, 60, 61, 62, 80, 81, 82],
      'categoryYarn': [200, 201, 300, 301, 400, 600, 603, 604, 606, 607, 800],
      'categoryFabric': [218, 219, 220, 222, 223, 224, 225, 226, 227, 229, 313, 314, 315, 317, 326, 410, 414, 611, 613, 614, 615, 617, 618, 619, 620, 621, 622, 624, 625, 626, 627, 628, 629, 810],
      'categoryApparel': [237, 239, 330, 331, 332, 333, 334, 335, 336, 338, 339, 340, 341, 342, 345, 347, 348, 349, 350, 351, 352, 353, 359, 431, 432, 433, 434, 435, 436, 438, 439, 440, 442, 443, 444, 445, 446, 447, 448, 459, 630, 631, 632, 633, 634, 635, 636, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 659, 735, 736, 738, 739, 740, 741, 745, 751, 752, 758, 759, 831, 832, 833, 834, 835, 836, 838, 839, 840, 842, 843, 844, 845, 846, 847, 850, 851, 852, 858, 859],
      'categoryMadeUps': [360, 361, 362, 363, 369, 464, 465, 469, 665, 666, 669, 670, 863, 870, 871, 899]
    }

    const MSR_GROUPS = {
      'groupAggregates' : this.reportName.includes('MSR Groups')
        ? [0,1,3,4,5,6,7]
        : [1, 2, 3, 4, 5, 6, 7],
      'groupApparel': [30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60],
      'groupYarn': [101, 102, 103],
      'groupFabric': [200, 201, 202, 203, 204, 205, 206],
      'groupMadeUps': [400, 401, 402, 403, 404, 405, 406, 408]
    }

    if (this.source === 'ANNUAL') {
      let allCategories = await this.repository.getOtexaCategories(this.source)
      this.allCategories = allCategories
      Object.keys(MSR_CATEGORIES).forEach(cat => {
        this[cat] = allCategories.filter(item => MSR_CATEGORIES[cat].includes(item.catId))
      })
    } else if (this.source === 'EXPORT') {
      let allGroups = await this.repository.getOtexaExportGroups()
      this.allGroups = allGroups.sort((a,b) => a.groupId - b.groupId)
      Object.keys(MSR_GROUPS).forEach(grp => {
        this[grp] = allGroups.filter(item => MSR_GROUPS[grp].includes(item.groupId))
      })
    }

    this.displayIn = 'DOLLARS'

    this.loading = false
  },
  methods: {
    getReportClass () {
      return this.isReportVisible ? 'sub-content visible' : 'hidden'
    },

    async viewReport () {
      let filters = []

      if (this.displayIn.length === 0) {
        filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))
      } else {
        filters.push(this.filter('Display In', 'In', [this.displayIn], true))
      }

      filters.push(this.filter('Country', 'All', [], false))

      if (this.source === 'ANNUAL') {
        let selectedCategories = this.allCategories
          .filter(c => [this.selectedCategories].includes(c.catId))
          .map(c => c.longCategory.trim())
        filters.push(this.filter('Category', 'In', selectedCategories, false))
      } else if (this.source === 'EXPORT') {
        let selectedGroups = this.allGroups
          .filter(c => [this.selectedGroups].includes(c.groupId))
          .map(c => c.longGroup.trim())
        filters.push(this.filter('Group', 'In', selectedGroups, false))
      }

      this.report = await this.repository.generateToken(
        this.$route.params.workspaceName,
        this.$route.params.reportName
      )

      var embedConfig = {
        id: this.report.powerBiReport.id,
        embedUrl: this.report.powerBiReport.embedUrl,
        accessToken: this.report.powerBiToken.token,
        type: 'report',
        tokenType: this.pbi.models.TokenType.Embed,
        permissions: this.pbi.models.Permissions.All,
        settings: {
          filterPaneEnabled: false,
          navContentPaneEnabled: false,
        }
      }

      let embedContainer = this.$refs['embed-container']

      window.powerbi.embed(embedContainer, embedConfig)

      const report = window.powerbi.get(embedContainer)
      report.on('loaded', async () => {
        this.loadingReport = false
        this.setTokenExpirationListener(this.report.powerBiToken.expiration)
        embedContainer.children[0].style.height = null;

        report.setFilters(filters)

        let pages = await report.getPages()
        pages.filter(p => p.displayName === 'Country')[0].setActive()
      })
      this.isReportVisible = true
    },
    reset () {
      this.selectedCategories = []
      this.selectedGroups = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection) {
      let table;
      if (this.reportName.includes('Export')) {
        table = 'OTEXA_EXPORTS_VW'
      } else {
        table = 'OTEXA_ANNUAL_VW'
      }
      return {
        requireSingleSelection,
        operator,
        values,
        $schema: 'http://powerbi.com/product/schema#basic',
        target: {
          column,
          table
        },
        filterType: 1
      }
    }
  }
}
</script>
<style scoped>
.sub-content {
  display: flex;
  flex-flow: column;
  height: 100%;
}

.visible {
  visibility: visible;
  height: 100%;
}

.hidden {
  visibility: hidden;
}

.filter-fields {
  display: flex;
  flex-wrap: wrap;
}

input,
label {
  display: block;
}

.filter-field {
  padding: 8px 12px;
}

.filter-field label {
  margin-bottom: 8px;
}

.filter-field select {
  padding: 4px 8px;
}

.filter-buttons {
  display: flex;
  justify-content: flex-end;
  padding: 8px;
}

.filter-buttons button {
  margin: 20px 0 0 20px;
}

p {
  padding: 8px;
}
</style>
