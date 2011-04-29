# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 13;

BEGIN {
    use_ok('WWW::Weather::Yahoo');
    use_ok('WWW::Mechanize');
    use_ok('XML::XPath');
    use_ok('XML::XPath::XMLParser');
}

my $weather = WWW::Weather::Yahoo->new( 'São Paulo, SP', 'c' );
isa_ok( $weather, 'WWW::Weather::Yahoo' );
is( $weather->{_weather}{unit_temperature},
    'C', 'Unit Temperature is Celcius, as expected.' );
is( $weather->{_weather}{location_country},
    'Brazil', 'Country for São Paulo should be Brazil.' );

$weather = WWW::Weather::Yahoo->new( 'Miami, FL', 'f' );
is( $weather->{_weather}{unit_temperature},
    'F', 'Unit Temperature is Celcius, as expected.' );
is(
    $weather->{_weather}{location_country},
    'United States',
    'Country for Miami, FL should be United States'
);

$weather = WWW::Weather::Yahoo->new('São Paulo, SP');
is( $weather->{_weather}{unit_temperature},
    'C', 'Default Unit Temperature is Celcius, as expected.' );
is( $weather->{_weather}{location_country},
    'Brazil', 'Country for São Paulo should be Brazil.' );

$weather = WWW::Weather::Yahoo->new('some invalid city');
is( $weather, undef,
'Invalid city name or city not found, try looking up your city name at http://weather.yahoo.com/ and use the correct city name.'
);



$weather = WWW::Weather::Yahoo->new( );
is( $weather, undef,
'Invalid city name or city not found, try looking up your city name at http://weather.yahoo.com/ and use the correct city name.'
);
