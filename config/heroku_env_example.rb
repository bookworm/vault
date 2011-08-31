if Padrino.env == :production  
  ENV['DOMAIN'] = 'domain'  
else
  ENV['DOMAIN'] = 'localhost:3000' 
end
ENV['ASSET_HOST']           = "http://assets%d-vault.kerickson.me"  
ENV['ASSET_HOST_COUNT']     = '4' 
ENV['S3_ACCESS_KEY']        = 'XXXXXXXXXXXXX'
ENV['S3_SECRET_ACCESS_KEY'] = 'XXXXXXXXXXXXXXXXXXXX'    

# VLAD/Deployment Enviroment Variables
ENV['DEPLOY_USER']      = "root"
ENV['APP_NAME']         = "idea_vault" 
ENV['SSH_USER']         = "root" 
ENV['DEPLOY_DOMAIN']    = "X.X.XX.XX"  
ENV['APP_DOMAIN']       = "vault.kerickson.me"
ENV['REPOSITORY']       = "ssh://#{ENV['DEPLOY_DOMAIN']}/home/#{ENV['DEPLOY_USER']}/repos/#{ENV['APP_NAME']}.git"
ENV['DEPLOY_TO']        = "/home/#{ENV['DEPLOY_USER']}/#{ENV['APP_DOMAIN']}/#{ENV['APP_NAME']}"     
ENV['NGINX_SITE_PATH']  = "/etc/nginx/sites-available/#{ENV['APP_DOMAIN']}"
ENV['DEPLOY_VIA']       = "git"

# Authorization
ENV['IP_ACCESS']        = 'XXX.XXX.XXX'