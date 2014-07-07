'use strict';

module.exports = function(grunt) {
    //load plugins
    [
        "grunt-contrib-jasmine",
        "grunt-contrib-testem",
        "grunt-contrib-clean",
        "grunt-contrib-coffee",
        "grunt-contrib-handlebars",
        "grunt-contrib-concat",
        "grunt-contrib-watch",
        "grunt-contrib-uglify"
    ].forEach(grunt.loadNpmTasks);

    grunt.initConfig({

        tmp: '.tmp/',
        dist: 'dist/',
        projectName: 'bbpicker',

        testem: {
            environment: {
                src: [
                    'vendor/js/lodash.js',
                    'vendor/js/jquery.js',
                    'vendor/js/handlebars.runtime.js',
                    'vendor/js/backbone.js',
                    'vendor/**/*.js',
                    "<%= tmp %>/handlebar_templates.js",
                    'src/**/*.coffee',
                    'spec/helpers/**/*.js',
                    'spec/**/*_spec.coffee'
                ],
                options: {
                    parallel: 8,
                    launch_in_ci: ['PhantomJS'],
                    launch_in_dev: ['PhantomJS', 'Chrome'],
                    framework: 'jasmine'
                }
            }
        },
        concat: {
            options: {
                separator: ';'
            },
            dist: {
                src: ['<%= tmp %>/handlebar_templates.js', '<%= tmp %><%= projectName %>.js'],
                dest: 'dist/<%= projectName %>.js'
            }
        },

        coffee: {
            compileJoined: {
                options: {
                    join: true
                },
                files: {
                    '<%= tmp %><%= projectName %>.js': ["src/*.coffee"]
                }
            }
        },
        handlebars: {
          compile: {
              options: {
                  namespace: "JST"
              },
              files: {
                  "<%= tmp %>/handlebar_templates.js": ["templates/**/*.hbs", "templates/**/*.handlebars", "templates/**/*.hb"]
              }
          }
        },
        uglify: {
            options: {
                mangle: false
            },
            build: {
                files: {
                    'dist/<%= projectName %>.min.js': ['.tmp/<%= projectName %>.js']
                }
            }
        },
        clean: ['<%= tmp %>', '<%= dist %>']
    });

    grunt.registerTask('coffee:compiledJoined','Compiles the Coffeescript source files', ['coffee:compileJoined']);
    grunt.registerTask('build', "Build Project", ['coffee:compileJoined', 'handlebars','concat', 'uglify'])
    grunt.registerTask('spec', 'Run the specs', ['handlebars', 'testem:run:environment'])

}
