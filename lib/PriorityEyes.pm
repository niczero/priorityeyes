package PriorityEyes;
use Mojo::Base 'Mojolicious';

our $VERSION = 0.001;

sub startup {
  my $self = shift;

  # Mode
  if ($self->mode eq 'production') {
    $self->plugin('Log::Timestamp' => {
      path => $self->home->rel_file('log/production.log'),
      level => 'info',
      pattern => '%y%m%d %X'
    }) if -w $self->home->rel_file('log');
    $self->plugin('Log::Access');
  }
  else {
    $self->plugin('Log::Timestamp' => {
      path => $self->home->rel_file('log/development.log'),
      level => 'debug',
      pattern => '%y%m%d %X'
    }) if -w $self->home->rel_file('log');
  }

  # Paths
  @{$self->static->paths} = $self->home->rel_dir('www');
  @{$self->renderer->paths} = $self->home->rel_dir('tmpl');

  $self->defaults(layout => 'loggedin');

  # Plugins
  $self->plugin(Config =>
      {file => $self->home->rel_file('cfg/priority_eyes.conf')});

  # Sessions
  # Reset auth tokens upon first restart of each day
  $self->secrets([
    map sprintf('%s%s', $_, (localtime)[7]), @{$self->config->secrets}
  ]);
  $self->sessions->default_expiration($self->config->expiration);

  $self->plugin(Authentication => {
    session_key => sprintf('peyes.%s', substr $self->mode, 0, 3),
    validate_user => \&Auth::validate_user,
    load_user => \&Auth::load_user,
    autoload_user => 1
  });

  $self->add_routes;
}

sub add_routes {
  my $self = shift;

  # Routes
  my $r = $self->routes;
  $r->get('/' => sub { return shift->redirect_to('main') });

  $r = $r->namespaces(['C'])->under('peyes');
  $r->get('/' => sub { return shift->redirect_to('main') });

  $r->get('login');

  $r->post('login')->to('auth#login', template => 'login');

#  $s->get('logout')->to('auth#logout');

  $r->get('main');
}

1;
__END__
