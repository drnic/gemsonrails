README for gems_to_rails
========================

Go to your rails app folder, run 'gemsonrails'. 

Then run either:

'rake gems:freeze GEM=<gemname> [VERSION=<versionnum>]' to freeze a gem, or 
'rake gems:link GEM=<gemname>' to link to whatever latest gem release is available at runtime.

You can restrict which RAILS_ENVs the gem will be loaded for, using ONLY; e.g.

'rake gems:freeze GEM=<gemname> ONLY=development' only in 'development' mode will the gem be loaded, or
'rake gems:link GEM=<gemname> ONLY=production,staging' only in 'production' or 'staging' mode will the gem be loaded from the deployment gem server
	