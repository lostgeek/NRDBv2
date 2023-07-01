import EmberRouter from '@ember/routing/router';
import config from 'netrunnerdb/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('home', { path: '/' }, function () {
    this.route('dotw', { path: '/' }); // Defaults to dotw
    this.route('dotw');
    this.route('banlists');
    this.route('community');
    this.route('decklists');
    this.route('developer');
    this.route('formats');
    this.route('sets');
    this.route('updates');
  });
  this.route('page', function () {
    this.route('banlists');
    this.route('card', { path: '/card/:id' });
    this.route('factions');
    this.route('faction', { path: '/faction/:id' });
    this.route('formats');
    this.route('sets');
    this.route('cycles');
    this.route('illustrators');
    this.route('reviews');
    this.route('rulings');
    this.route('search');
    this.route('advanced-search');
    this.route('syntax');
  });
});
