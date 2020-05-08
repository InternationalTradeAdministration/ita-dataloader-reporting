const request = require('request')
const config = require('../config/config.js')
const guid = require('guid')

function validateConfig() {
  if (!config.params.tenantId) {
    return 'TenantId is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!guid.isGuid(config.params.tenantId)) {
    return 'TenantId must be a Guid object. please register your application as Native app in https://dev.powerbi.com/apps and fill application Id in config.js'
  }

  if (!config.params.clientSecret) {
    return 'ClientSecret is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!config.params.clientId) {
    return 'ClientId is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!guid.isGuid(config.params.clientId)) {
    return 'ClientId must be a Guid object. please register your application as Native app in https://dev.powerbi.com/apps and fill application Id in config.js'
  }

  if (!config.params.authorityUrl) {
    return 'AuthorityUrl is empty. Please fill valid AuthorityUrl under config.js'
  }
}

async function listGroups(accessToken, filter) {
  const url = (filter) ? buildBaseUrl() + filter : buildBaseUrl()
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'GET')
  return sendRequest(requestParmas)
}

async function listReports(accessToken, workspaceId, filter) {
  let url = buildBaseUrl(workspaceId) + '/reports'
  if (filter) url = url + filter
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'GET')
  return sendRequest(requestParmas)
}

async function getReport(accessToken, workspaceId, reportId) {
  const url = buildBaseUrl(workspaceId) + '/reports/' + reportId
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'GET')
  return sendRequest(requestParmas)
}

async function getEmbedToken(accessToken, workspaceId, reportId) {
  const url = buildBaseUrl(workspaceId) + '/reports/' + reportId + '/GenerateToken'
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'POST', JSON.stringify({ accessLevel: 'View' }))
  return sendRequest(requestParmas)
}

function buildBaseUrl(workspaceId) {
  const tmpWorkspaceId = workspaceId ? workspaceId : ''
  return config.params.apiUrl + 'v1.0/myorg/groups/' + tmpWorkspaceId
}

function buildHttpRequestParameters(url, accessToken, method, body) {
  return {
    url,
    options: {
      method,
      body,
      headers: {
        Authorization: 'Bearer '.concat(accessToken),
        'Content-Type': 'application/json'
      }
    }
  }
}

async function sendRequest(requestParmas) {
  return new Promise(
    (resolve, reject) => {
      request(requestParmas.url, requestParmas.options, function (error, response, body) {
        if (error) {
          reject(error)
        } else {
          resolve(JSON.parse(body))
        }
      })
    })
}

module.exports = {
  validateConfig: validateConfig,
  listGroups: listGroups,
  listReports: listReports,
  getReport: getReport,
  getEmbedToken: getEmbedToken
}
