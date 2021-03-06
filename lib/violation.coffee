_ = require 'lodash'
util = require './util'

module.exports =
class Violation
  @SEVERITIES = ['warning', 'error']

  constructor: (@severity, @bufferRange, @message, @metadata = []) ->
    unless _.contains(Violation.SEVERITIES, @severity)
      message  = "Severity must be any of #{Violation.SEVERITIES.join(',')}. "
      message += "#{@severity} is passed."
      throw new Error(message)

  getMessageHTML: ->
    HTML = util.punctuate(util.capitalize(@message))
    HTML = _.escape(HTML)
    HTML.replace(/(^|\s)(`|&#39;)(.+?)\2([\s\.\,\:\;\!\?\)]|$)/g, '$1<code>$3</code>$4')

  getAttachmentHTML: ->
    null

  getMetadataHTML: ->
    elements = ("<span class=\"item\">#{_.escape(item)}</span>" for item in @metadata)
    elements.join('')
