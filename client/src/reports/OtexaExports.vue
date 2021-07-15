<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="filter-field" v-if="!reportName.includes('Monthly')">
            <label>Data By:</label>
            <select v-model="onlyCountry" @click="reset()" size="2">
              <option :value="true">Country</option>
              <option :value="false">Group/Category</option>
            </select>
          </div>
          <div class="regions" v-if="onlyCountry || reportName.includes('Monthly')">
            <div class="filter-field">
              <label for="CountryGroups">Country Groups:</label>
              <select
                v-model="selectedCountryGroups"
                :name=CountryGroups
                :id=CountryGroups
                multiple
                size="20"
              >
                <option
                  v-for="item in CountryGroups"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Africa">Africa:</label>
              <select
                v-model="selectedAfrica"
                :name=Africa
                :id=Africa
                multiple
                size="20"
              >
                <option
                  v-for="item in Africa"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Asia">Asia:</label>
              <select
                v-model="selectedAsia"
                :name=Asia
                :id=Asia
                multiple
                size="20"
              >
                <option
                  v-for="item in Asia"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="AustraliaAndOceania">Australia and Oceania:</label>
              <select
                v-model="selectedAustraliaAndOceania"
                :name=AustraliaAndOceania
                :id=AustraliaAndOceania
                multiple
                size="20"
              >
                <option
                  v-for="item in AustraliaAndOceania"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Europe">Europe:</label>
              <select
                v-model="selectedEurope"
                :name=Europe
                :id=Europe
                multiple
                size="20"
              >
                <option
                  v-for="item in Europe"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="NorthAndCentralAmerica">North and Central America:</label>
              <select
                v-model="selectedNorthAndCentralAmerica"
                :name=NorthAndCentralAmerica
                :id=NorthAndCentralAmerica
                multiple
                size="20"
              >
                <option
                  v-for="item in NorthAndCentralAmerica"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="SouthAmerica">South America:</label>
              <select
                v-model="selectedSouthAmerica"
                :name=SouthAmerica
                :id=SouthAmerica
                multiple
                size="20"
              >
                <option
                  v-for="item in SouthAmerica"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
          </div>
          <div class="filter-field" v-if="(!onlyCountry || reportName.includes('Monthly')) && reportName.includes('Footwear')">
            <label for="categories">Categories:</label>
            <select
              v-model="selectedCategories"
              name="categories"
              id="categories"
              multiple
              size="25"
              @change="updateScheduleB()"
            >
              <option
                v-for="item in categories"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-else-if="!onlyCountry">
            <label for="groups">Groups:</label>
            <select
              v-model="selectedGroups"
              name="groups"
              id="groups"
              multiple
              size="25"
              @change="updateScheduleB()"
            >
              <option
                v-for="item in groups"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.longGroup }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="(!onlyCountry && (!reportName.includes('Monthly') && this.reportName !== 'Export Data (Historical)' && !reportName.includes('all years'))) ">
            <label for="chapters">Chapters:</label>
            <select
              v-model="selectedChapters"
              name="chapters"
              id="chapters"
              multiple
              size="25"
              @change="updateScheduleB()"
            >
              <option
                v-for="item in chapters"
                :key="item.chapter"
                :value="item.chapter"
                >{{ item.longChapter }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="(!onlyCountry && (!reportName.includes('Monthly') && this.reportName !== 'Export Data (Historical)' && !reportName.includes('all years')))">
            <label for="scheduleB">Schedule B:</label>
            <span v-if="loadingScheduleB">loading...</span>
            <select
              v-else
              v-model="selectedScheduleB"
              name="scheduleB"
              id="scheduleB"
              multiple
              size="25"
            >
              <option v-for="item in scheduleB" :key="item.scheduleB" :value="item.scheduleB">{{
                item.longSchedb
              }}</option>
            </select>
          </div>
          <div class="filter-field years" v-if="reportName.includes('Historical') || reportName.includes('Monthly')">
            <label for="years">*Years:</label>
            <select
              v-model="selectedYears"
              name="years"
              id="years"
              multiple
              size="20"
            >
              <option
                v-for="item in years"
                :key="item[yearKey]"
                :value="item[yearKey]"
              >{{ item[yearKey] }}</option>
            </select>
          </div>
          <div v-if="this.reportName !== 'Export Data (Historical)' && !reportName.includes('Monthly')" class="filter-field">
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="2"
            >
              <option value='DOLLARS'>DOLLARS</option>
              <option v-if="this.reportName.includes('Footwear')" value='QTY'>QTY</option>
              <option v-else value='UNITS'>UNITS</option>
            </select>
          </div>
        </div>
        <p v-if="(!onlyCountry || reportName.includes('Historical'))">
          *Multiple selections will be added together (use the Shift key for
          sequential selections and the Ctrl key for non-sequential ones).
        </p>
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
import { uniqNames } from '@/utils/helpers'
export default {
  name: 'OtexaExports',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    source: null,
    countries: [],
    categories: [],
    groups: [],
    chapters: [],
    scheduleB: [],
    years: [],
    yearKey: null,
    selectedCountries: [],
    selectedCategories: [],
    selectedGroups: [],
    selectedChapters: [],
    selectedScheduleB: [],
    selectedYears: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
    loadingScheduleB: false,
    onlyCountry: null,
    CountryGroups: [],
    selectedCountryGroups: [],
    Africa: [],
    selectedAfrica: [],
    Asia: [],
    selectedAsia: [],
    AustraliaAndOceania: [],
    selectedAustraliaAndOceania: [],
    Europe: [],
    selectedEurope: [],
    NorthAndCentralAmerica: [],
    selectedNorthAndCentralAmerica: [],
    SouthAmerica: [],
    selectedSouthAmerica: []
  }),
  async created () {
    this.onlyCountry = (this.$route.query.onlyCountry || this.reportName.includes('Group'))
      ? (this.$route.query.onlyCountry === 'true' || this.reportName.includes('Country'))
      : false

    this.source = this.reportName.includes('Footwear')
      ? 'EXPORT_FOOTWEAR'
      : 'EXPORT'

    if (this.source == 'EXPORT') {
      let groups = await this.repository.getOtexaExportGroups()
      this.groups = groups.sort((a,b) => a.groupId - b.groupId)
    }

    if (this.source == 'EXPORT_FOOTWEAR') {
      this.categories = await this.repository.getOtexaCategories(this.source)
    }
    this.countries = await this.repository.getOtexaCountries(this.source)
    this['CountryGroups'] = this.countries.filter(country => country.ctryGroup === 'Country Groups')
    let AFRICA = this.countries.filter(country => country.ctryGroup === 'Africa')
    this['Africa'] = uniqNames(AFRICA, "ctryDescription")
    let ASIA = this.countries.filter(country => country.ctryGroup === 'Asia')
    this['Asia'] = uniqNames(ASIA, "ctryDescription")
    let OCEANIA = this.countries.filter(country => country.ctryGroup === 'Australia and Oceania')
    this['AustraliaAndOceania'] = uniqNames(OCEANIA, "ctryDescription")
    let EUROPE = this.countries.filter(country => country.ctryGroup === 'Europe')
    this['Europe'] = uniqNames(EUROPE, "ctryDescription")
    let NCAMERICA = this.countries.filter(country => country.ctryGroup === 'North and Central America')
    this['NorthAndCentralAmerica'] = uniqNames(NCAMERICA, "ctryDescription")
    let SAMERICA = this.countries.filter(country => country.ctryGroup === 'South America')
    this['SouthAmerica'] = uniqNames(SAMERICA, "ctryDescription")

    this.chapters = await this.repository.getScheduleBChapters(this.source)
    this.chapters = this.chapters.filter(chapter => chapter.longChapter.length >3)

    if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
      this.years = await this.repository.getOtexaMonthlyYears('MONTHLY_FOOTWEAR')
      this.yearKey = 'year'
    } else if (this.reportName.includes('Monthly')) {
      this.years = await this.repository.getOtexaMonthlyYears('MONTHLY')
      this.yearKey = 'year'
    } else if (this.reportName.includes('Footwear')) {
      this.years = await this.repository.getOtexaFootwearYears()
      this.yearKey = 'dataKey'
    } else {
      let years = await this.repository.getOtexaYears()
      this.years = years.filter(year => !year.headerDescription.includes('Quarter'))
      this.yearKey = 'headerDescription'
    }

    this.displayIn = 'DOLLARS'

    this.loading = false
  },
  methods: {
    getReportClass () {
      return this.isReportVisible ? 'sub-content visible' : 'hidden'
    },
    async updateScheduleB () {
      if (!this.scheduleBDisabled()) {
        this.loadingScheduleB = true
        if (this.source == 'EXPORT' && this.reportName !== 'Export Data (Historical)') {
          this.scheduleB = await this.repository.getOtexaScheduleB(
            this.selectedGroups,
            this.selectedChapters,
            this.source
          )
        } else if (this.source == 'EXPORT_FOOTWEAR') {
          this.scheduleB = await this.repository.getOtexaScheduleBByCat(
            this.selectedCategories,
            this.selectedChapters,
            this.source
          )
        }
        this.loadingScheduleB = false
      }
    },
    scheduleBDisabled () {
      return !(
        this.selectedGroups.length > 0 || this.selectedCategories.length > 0 || this.selectedChapters.length > 0
      )
    },
    async viewReport () {
      let filters = []
      let scheduleBPageFilters = []
      let allSelectedCountries = [].concat(this.selectedCountryGroups, this.selectedAfrica, this.selectedAsia, this.selectedAustraliaAndOceania, this.selectedEurope, this.selectedNorthAndCentralAmerica, this.selectedSouthAmerica)

      if (!this.reportName.includes('Monthly')) {
        if (this.displayIn.length === 0) {
          filters.push(this.filter('Display In', 'In', ['DOLLARS'], true, true))
        } else if (this.reportName !== 'Export Data (Historical)') {
          filters.push(this.filter('Display In', 'In', [this.displayIn], true, true))
        }
      }

      if (allSelectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => allSelectedCountries.includes(c.ctryNumber))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false, true))
      } else {
        filters.push(this.filter('Country', 'All', [], false, false))
      }

      if (this.source == 'EXPORT') {
        if (this.selectedGroups.length > 0) {
          let selectedGroups = this.groups
            .filter(g => this.selectedGroups.includes(g.groupId))
            .map(g => g.longGroup.trim())
          filters.push(this.filter('Group', 'In', selectedGroups, false, true))
        } else {
          filters.push(this.filter('Group', 'All', [], false, false))
        }
      } else if (this.source == 'EXPORT_FOOTWEAR') {
        if (this.selectedCategories.length > 0) {
          let selectedCategories = this.categories
            .filter(g => this.selectedCategories.includes(g.catId))
            .map(g => g.longCategory.trim())
          filters.push(this.filter('Category', 'In', selectedCategories, false, true))
        } else {
          filters.push(this.filter('Category', 'All', [], false, false))
        }
      }

      if (!this.reportName.includes('all years')) {
        if (this.selectedChapters.length > 0 ) {
          let selectedChapters = this.chapters
            .filter(c => this.selectedChapters.includes(c.chapter))
            .map(c => c.longChapter.trim())
          filters.push(this.filter('Chapter', 'In', selectedChapters, false, false))
        } else if (this.reportName !== 'Export Data (Historical)') {
          filters.push(this.filter('Chapter', 'All', [], false, false))
        }
      }

      if (!this.reportName.includes('all years')) {
        if (this.selectedScheduleB.length > 0 && !this.reportName.includes('all years')) {
          let selectedScheduleB = this.scheduleB
            .filter(c => this.selectedScheduleB.includes(c.scheduleB))
            .map(c => c.longSchedb.trim())
          filters.push(this.filter('Schedule B', 'In', selectedScheduleB, false, false))
        } else if (this.reportName !== 'Export Data (Historical)') {
          filters.push(this.filter('Schedule B', 'All', [], false, false))
        }
      }

      if (this.reportName !== 'Export Data (Historical)' && !this.reportName.includes('all years')) {
        scheduleBPageFilters.push(this.advancedFilter('Schedule B', 'And', 'IsNotBlank', null))
      }

      if (this.reportName.includes('Historical') || this.reportName.includes('Monthly')) {
        if (this.selectedYears.length > 0) {
          let selectedYears = this.selectedYears
          filters.push(this.filter('Year', 'In', selectedYears, false, false))
        } else {
          filters.push(this.filter('Year', 'All', [], false, false))
        }
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
          filterPaneEnabled: true,
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
        let countryPage = pages.filter(p => p.displayName === 'Country')[0]
        let scheduleBPage = pages.filter(p => p.displayName === 'Schedule B')[0]

        if (this.reportName !== 'Export Data (Historical)' && !this.reportName.includes('all years')) {
          scheduleBPage.setFilters(scheduleBPageFilters)
        }

        if (!this.onlyCountry) {
          countryPage.setActive()
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountryGroups = []
      this.selectedAfrica = []
      this.selectedAsia = []
      this.selectedAustraliaAndOceania = []
      this.selectedEurope = []
      this.selectedNorthAndCentralAmerica = []
      this.selectedSouthAmerica = []
      this.selectedCategories = []
      this.selectedGroups = []
      this.selectedChapters = []
      this.selectedScheduleB = []
      this.selectedYears = []
      this.scheduleB = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection, isHidden = false) {
      let table;
      if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
        table = 'OTEXA_MONTHLY_FOOTWEAR_EXPORTS_VW'
      } else if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_EXPORT_FOOTWEAR_VW'
      } else if (this.reportName == 'Export Data (Historical)' || this.reportName.includes('all years')) {
        table = 'OTEXA_EXPORTS_HISTORICAL_VW'
      } else {
        table = 'OTEXA_EXPORTS_VW'
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
        filterType: 1,
        displaySettings: {
          isHiddenInViewMode: isHidden
        }
      }
    },
    advancedFilter (column, logicalOperator, operator, value) {
      let table;
      if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
        table = 'OTEXA_MONTHLY_FOOTWEAR_EXPORTS_VW'
      } else if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_EXPORT_FOOTWEAR_VW'
      } else if (this.reportName == 'Export Data (Historical)' || this.reportName.includes('all years')) {
        table = 'OTEXA_EXPORTS_HISTORICAL_VW'
      } else {
        table = 'OTEXA_EXPORTS_VW'
      }
      return {
        logicalOperator,
        conditions: [
          {
            operator: operator,
            value: value
          }
        ],
        $schema: 'http://powerbi.com/product/schema#advanced',
        target: {
          column,
          table
        },
        filterType: 0,
        displaySettings: {
          isHiddenInViewMode: true
        }
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

.filter-fields, .regions {
  display: inline-flex;
  flex-wrap: wrap;
}

.regions select {
  width: 150px;
}

input,
label {
  display: block;
}

[multiple] {
  min-width: 100px;
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
