module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')
  grunt.initConfig
    pkg: pkg
    'http-server':
      start:
        root: './'
        port: 3000
        host: '0.0.0.0'
    browserify:
      dist:
        files:
          'browser.js': ['./src/game.coffee']
        options:
          watch: true
          keepAlive: true
          transform: ['coffeeify']
    coffeelint:
      app: 
        files:
          src: ['src/*.coffee']
        options:
          force: true
    concurrent:
      start:
        tasks: ['http-server:start', 'browserify']
        options:
          logConcurrentOutput: true
        
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-http-server'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['concurrent:start']