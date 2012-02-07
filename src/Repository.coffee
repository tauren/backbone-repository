Backbone = require 'backbone'

# class Reference
#   constructor: (model) ->
#     @model = model
#     @id = model.id
#     @cid = model.cid
#     # @ref = 1
#     @incrementRef()
#     @setExpires model.constructor.timeout
#   setExpires: (timeout) ->
#     @expires = new Date(new Date().getTime() + timeout*1000)
#   incrementRef: ->
#     @ref = if @ref then @ref++ else 1

class Repository extends Backbone.Model
  constructor: (attr, opts) ->
    Backbone.Model.prototype.constructor.call @, attr, opts
    @incrementRef()
    @setExpires @.constructor.timeout
    Repository.add @
  meta: {}
  setExpires: (timeout) ->
    @meta.expires = new Date(new Date().getTime() + timeout*1000)
  incrementRef: ->
    @meta.ref = if @ref then @ref++ else 1

  # Class properties and methods below here (note the @ prefix)

  # Repository to store model instances
  @repo: {}

  # Time in seconds before instances timeout, default 5 mins
  @timeout: 300

  # Add a model instance to this Model's repository
  @add: (inst) ->
    type = inst.constructor.type
    return if not type
    @repo[type] = @repo[type] or {}
    # obj = new Reference inst
    # @repo[type][inst.id] = obj
    @repo[type][inst.id] = inst

  # Get all model instances from this Model's repository
  # @all: ->
  #   return if not @type
  #   repo = @repo[@type] if @type
  #   models = ref.model for key, ref of repo
  @all: ->
    return @repo[@type] if @type
    @repo

  # Get references to all model instances from this Model's repository
  # @references: ->
  #   return @repo[@type] if @type
  #   @repo

  # Find a specific model instance from this Model's repository
  @find: (id) ->
    return if not @type
    @repo[@type][id]


module.exports = Repository
