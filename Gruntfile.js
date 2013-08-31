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
        "grunt-watch-nospawn",
        "grunt-contrib-uglify"
    ].forEach(grunt.loadNpmTasks);

    grunt.initConfig({

        tmp: '.tmp/',
        dist: 'dist/',
        projectName: 'projectName',

        testem: {
            environment: {
                src: [
                    'vendor/**/*.js',
                    'src/**/*.coffee',
                    'spec/helpers/**/*.js',
                    'spec/**/*_spec.coffee'
                ],
                options: {
                    parallel: 8,
                    launch_in_ci: ['PhantomJS'],
                    launch_in_dev: ['PhantomJS', 'Chrome']
                }
            }
        },
        concat: {
            options: {
                separator: ';'
            },
            dist: {
                src: ['<%= tmp %><%= projectName %>.js'],
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
    grunt.registerTask('build', "Build Project", ['coffee:compileJoined', 'concat', 'uglify'])

}