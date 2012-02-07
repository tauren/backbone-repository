# Backbone-Repository

This implementation is not yet complete.

Provides a Repository model that extends Backbone.Model. This Repository model has static methods and properties that will automatically maintain a repository of all backbone models of a particular type. 

If you are creating various Backbone collections of a particular type of model, and those collections may contain the same model, enables you to only have one instance of any given model.

Is there already something built in to Backbone that does this? Should I just use a Backbone collection? Just how useful is this? 

It doesn't look like backbone keeps any internal reference to models to make sure they only have one instance. Backbone collections prevent the same model from being added twice by throwing an error, but it is based on the cid. I think it would be possible to fetch the same model multiple times and add it to the same collection, as long as each model has a unique cid.

Currently, only a set of tests are implemented. To run these tests:

    cd backbone-repository
    vows --spec

Backbone-Repository is dependent on backbone, coffee-script, and vows:

    npm install coffee-script -g
    npm install vows -g
    npm install backbone
    npm link coffee-script
    npm link vows    
  
## TODO

* Implement a custom sync so that all interactions go through the Repository
* The Repository should be responsible for fetching, saving, and so forth
* Should return cached models, or fetch model again if cache expired
* Have a cleanup process that runs periodically and removes expired models
* Remove models with zero references?
* Elegantly handle nested models


