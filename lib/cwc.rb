# CWC API

# Resources
require 'net/http'
require 'ansi'

# CWC related libs
require "cwc/version"
require "cwc/utils/url"
require "cwc/utils/xml"
require "cwc/cwc"

# API
require "cwc/api/client"
require "cwc/api/message"
require "cwc/api/offices"

# Errors
require "cwc/errors/cwc_error"
require "cwc/errors/api_error"
require "cwc/errors/authentication_error"
require "cwc/errors/general_error"
require "cwc/errors/settings_error"