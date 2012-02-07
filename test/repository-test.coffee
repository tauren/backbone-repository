vows = require 'vows'
assert = require 'assert'
Repository = require '../src/Repository'

class Member extends Repository
  @type: 'Member'
  @timeout: 3600

class Project extends Repository
  @type: 'Project'

size = (obj) -> 
  (key for own key of obj).length

vows
  .describe('Backbone Repository')
  .addBatch
    'Private size(obj) method': 
      topic:
        a: 1
        b: 2
        c: 3 
      'result is 3': (topic) ->
        assert.equal size(topic), 3
  .addBatch
    'Member':
      topic: -> 
        m1 = new Member
          id: 'm1'
          username: 'tom'
          first: 'Tom'
          last: 'Jones'
        m2 = new Member
          id: 'm2'
          username: 'sally'
          first: 'Sally'
          last: 'Smith'
        Member
      'repository':
        'contains 2 models': (repo) ->
          all = repo.all()
          assert.equal size(all), 2
        'contains m1': (repo) ->
          all = repo.all()
          assert.equal all.m1?.id, 'm1'
        'contains m2': (repo) ->
          all = repo.all()
          assert.equal all.m2?.id, 'm2'
        'does not contain m3': (repo) ->
          all = repo.all()
          assert.isUndefined all.m3?.id, 'm3'
      'model m1':
        topic: (repo) ->
          repo.find('m1')
        'is found': (model) ->
          assert.isObject model
        'is a Member': (model) ->
          assert.instanceOf model, Member
        'is Tom Jones': (model) ->
          assert.equal model.get('first'), 'Tom'
          assert.equal model.get('last'), 'Jones'
      'model m2':
        topic: (repo) ->
          repo.find('m2')
        'is found': (model) ->
          assert.isObject model
        'is a Member': (model) ->
          assert.instanceOf model, Member
        'is Sally Smith': (model) ->
          assert.equal model.get('first'), 'Sally'
          assert.equal model.get('last'), 'Smith'
  .addBatch
    'Project':
      topic: -> 
        m1 = new Project
          id: 'p1'
          name: 'Go to Moon'
        m2 = new Project
          id: 'p2'
          name: 'Live on Mars'
        Project
      'repository':
        'contains 2 models': (repo) ->
          all = repo.all()
          assert.equal size(all), 2
        'contains p1': (repo) ->
          all = repo.all()
          assert.equal all.p1?.id, 'p1'
        'contains p2': (repo) ->
          all = repo.all()
          assert.equal all.p2?.id, 'p2'
        'does not contain p3': (repo) ->
          all = repo.all()
          assert.isUndefined all.p3?.id, 'p3'
      'model p1':
        topic: (repo) ->
          repo.find('p1')
        'is found': (model) ->
          assert.isObject model
        'is a Project': (model) ->
          assert.instanceOf model, Project
        'is Go to Moon': (model) ->
          assert.equal model.get('name'), 'Go to Moon'
      'model p2':
        topic: (repo) ->
          repo.find('p2')
        'is found': (model) ->
          assert.isObject model
        'is a Project': (model) ->
          assert.instanceOf model, Project
        'is Live on Mars': (model) ->
          assert.equal model.get('name'), 'Live on Mars'
  .export module
