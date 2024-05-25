import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import { Input } from '@ember/component';
import { on } from '@ember/modifier';
import { get } from '@ember/helper';

export default class BasicSearchInput extends Component {
  @tracked input = '';
  @tracked filters = {};

  available_filters = {
    t: ['type'],
    s: ['subtype'],
    o: ['cost'],
    g: ['advancement cost', 'advancement'],
  };

  @action
  handleKeyDown(event) {
    if (event.key === 'Tab') {
      console.log('prevent Tab and do autocompletion');
      event.preventDefault();
    }
  }
  @action
  handleKeyUp(event) {
    if (this.input.endsWith(' ')) {
      const splits = this.input.split(' ');
      const last = splits[splits.length - 2];
      const rest = splits.slice(0, splits.length - 2).join(' ');
      const [key, value] = last.split(':');

      const option = Object.entries(this.available_filters).find(
        ([type, options]) =>
          type === key.toLowerCase() || options.includes(key.toLowerCase()),
      );
      if (option) {
        this.filters[option[0]] = value;
        this.filters = this.filters;
        console.log(this.filters);
        this.input = rest + ' ';
      }
    }
  }

  capitalize = (text) => {
    return text.charAt(0).toUpperCase() + text.substr(1);
  };

  <template>
    <div class="input-group mb-3">
      {{#each-in this.filters as |type value|}}
      <span class="input-group-text">
        <span class="badge badge-secondary me-1">{{this.capitalize (get (get this.available_filters type) 0) }}</span>
        {{value}}
      </span>
      {{/each-in}}
      <Input class="form-control" @type="text" @value={{this.input}} {{on "keydown" this.handleKeyDown}} {{on "keyup" this.handleKeyUp}} />
    </div>
  </template>
}
