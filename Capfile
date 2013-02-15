load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
load 'deploy/assets' # remove this line to skip loading any of the default tasks
Dir['vendor/gems/*/recipes/*.rb','bendor/plugins/*/recipes//*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' #remove this line to skip loading any of the default tasks