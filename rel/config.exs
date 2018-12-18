use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :dev
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :prod
  set vm_args: "rel/vm.args"
end

release :travis_release do
  set version: current_version(:travis_release)
  set applications: [:runtime_tools]
end
