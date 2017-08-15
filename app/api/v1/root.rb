require 'grape-swagger'

module V1
  class Root < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    mount V1::Users
    add_swagger_documentation \
    doc_version: '0.1.0',
    info: {
      title: "SAMPLE APP",
      description: "This is the sample application for the tutorial.",
      contact_name: "kfurue",
      contact_email: "contact@example.com",
      contact_url: "http://example.com/contact",
      license: "the MIT License",
      license_url: "https://bitbucket.org/railstutorial/sample_app_4th_ed/src/2e80e463c7900e329555116119060f2a05f693cd/LICENSE.md?fileviewer=file-view-default"
    },
    security_definitions: {
      oauthAccessCode: {
        type: "oauth2",
        authorizationUrl: "https://fierce-wave-40771.herokuapp.com/oauth/authorize",
        tokenUrl: 'https://fierce-wave-40771.herokuapp.com/oauth/token',
        flow: "accessCode",
        scopes: {
          user: "User scope"
        }
      },
      oauthImplicit: {
        type: "oauth2",
        authorizationUrl: "https://fierce-wave-40771.herokuapp.com/oauth/authorize",
        flow: "implicit",
        scopes: {
          user: "User scope"
        }
      }
    }

  end
end
