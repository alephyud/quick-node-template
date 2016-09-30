initApp = (app, next) ->
  app.get '/', (req, res) ->
    res.render 'index', {metas: []}
  next null

exports = module.exports = {initApp}