http = require 'http'
path = require 'path'
express = require 'express'
bodyParser = require 'body-parser'
morganAppLogger = require 'morgan'
session = require 'express-session'

appModule = require './app'

app = express()
app.set 'views', global.APP_DIR + 'views'
app.set 'view engine', 'jade'
if app.get('env') == 'development'
  app.locals.pretty = true
else
  app.set 'view cache', true

app.use express.static path.join global.APP_DIR, 'public'
app.use '/public', express.static global.APP_DIR + '/public'
app.get '/favicon.ico', (req, res) ->
  res.sendStatus(200).end()

app.use morganAppLogger 'tiny'

app.use session
  secret: 'QuoppySessionSecret'
  resave: false
  saveUninitialized: false

console.log 'Launching app'
appModule.initApp app, (err) ->
  if err
    console.log err
  else
    port = process.env.PORT || 3001
    ip = process.env.IP || '0.0.0.0'
    http.createServer(app).listen port, ip, ->
      console.log "Server listening on port #{port}"
      console.log "Environment: #{app.get 'env'}"
