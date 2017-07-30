module API
  class Root < Grape::API
    mount V1::Root
    mount V2::Root
  end
end
