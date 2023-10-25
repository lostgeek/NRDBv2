import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { eq } from '../../utils/template-operators';

export default class SearchFormComponent extends Component {
  @service router;

  @action doSearch(e) {
    e.preventDefault();

    const searchParams = {};
    if (e.target.max_records.value) {
      searchParams.max_records = e.target.max_records.value;
    }
    if (e.target.latest_printing_only.value) {
      searchParams.latest_printing_only = e.target.latest_printing_only.value;
    }
    if (e.target.title.value) {
      searchParams.title = e.target.title.value;
    }
    if (e.target.text.value) {
      searchParams.text = e.target.text.value;
    }
    if (e.target.flavor.value) {
      searchParams.flavor = e.target.flavor.value;
    }

    console.table(searchParams);
    this.router.transitionTo('page.advanced-search', {
      queryParams: searchParams,
    });
  }

  <template>
    <h1>Search Form</h1>

    {{#if @searchParams.query}}
    <p>Free form query is: <strong>{{ @searchParams.query }}</strong></p>
    {{/if}}

    <div>
        <form id='advanced-search' {{ on 'submit' this.doSearch }}>
        <p>
          <label for="max_records">Max Records</label>
          <select id="max_records">
              <option value="25" selected={{eq @searchParams.max_records "25"}}>25</option>
              <option value="50" selected={{eq @searchParams.max_records "50"}}>50</option>
              <option value="100" selected={{eq @searchParams.max_records "100"}}>100</option>
              <option value="250" selected={{eq @searchParams.max_records "250"}}>250</option>
              <option value="500" selected={{eq @searchParams.max_records "500"}}>500</option>
              <option value="1000" selected={{eq @searchParams.max_records "1000"}}>1000</option>
          </select>
        </p>
        <p>
            <label for="latest_printing_only">Latest Printing Only</label>
            <input id="latest_printing_only" type="checkbox" checked={{eq @searchParams.latest_printing_only "true"}} value="true" />
        </p>
        <p>
          <label for="title">Title:</label> <input type="text" id="title" value="{{ @searchParams.title }}" />
        </p>
        <p>
          <label for="text">Text:</label> <input type="text" id="text" value="{{ @searchParams.text }}" />
        </p>
        <p>
          <label for="flavor">Flavor:</label> <input type="text" id="flavor" value="{{ @searchParams.flavor }}" />
        </p>
        <p>
          <input type="submit" />
        </p>

        <pre>
        == Result Type

        # of records

        [checkbox] Latest Printing Only

        Sort by

        View As

        == Basic Card Attributes
        title, _: Type: string
        text, x: Type: string

        side, d: Type: string
        side_id of the card.

        faction, f: Type: string
        faction_id of this card.

        card_subtype, s: Type: array
        text names for card subtypes, matched as lowercase.

        card_subtype_id: Type: array
        card_subtype_ids for the card.

        agenda_points, v: Type: integer
        The printed number of agenda points for the agenda.

        cost, o: Type: integer
        The printed cost of a card. Accepts positive integers and X (case-insensitive).

        influence_cost, n: Type: integer
        The influence cost or number of influence pips for the card.

        is_unique, u: Type: boolean
        Is the card unique?

        advancement_cost, g: Type: integer
        The advancement_cost value for an agenda. Accepts positive integers and X (case-insensitive).

        base_link, l: Type: integer
        The printed link value for an Identity.

        memory_usage, m: Type: integer
        The memory (MU) cost of this card.

        strength, p: Type: integer
        The strength of the card. Accepts integers or X.

        trash_cost, h: Type: integer
        The trash cost of this card.

        == Advanced Card Attributes
        additional_cost: Type: boolean
        Does the card text specify an additional cost to play?

        advanceable: Type: boolean
        Is the card advanceable?

        gains_subroutines: Type: boolean
        Does the card text allow for adding or gaining subroutines?

        interrupt: Type: boolean
        Does the card have an interrupt ability?

        on_encounter_effect: Type: boolean
        Does the card text specify an on encounter effect?

        performs_trace: Type: boolean
        Does the card perform a trace?

        rez_effect: Type: boolean
        Does the card have a rez effect?

        trash_ability: Type: boolean
        Does the card provide a trash ability?

        link_provided: Type: integer
        The amount of link provided.

        mu_provided: Type: integer
        The amount of memory (MU) provided by the card.

        num_printed_subroutines: Type: integer
        The number of printed subroutines on this card.

        recurring_credits_provided: Type: integer
        The number of recurring credits provided by this card. Accepts integers or X.

        == Attribution
        designed_by: Type: string
        The organization that designed the card.

        released_by: Type: string
        The organization that released the printing.

        printings_released_by: Type: array
        All organizations that have released printings for a card.

        release_date, date_release, r: Type: date
        The earliest release date for a card or the release date for the set for a printing.

        attribution: Type: string
        The designer of this card text, if specified.

        == Flavor & Illustrators
        flavor, flavour, a: Type: string
        The flavor text for a printing.

        illustrator, i: Type: string
        The printed version of the illustrator credits, with multiple illustrators separated by commas.

        illustrator_id: Type: array
        illustrator_id for an illustrator for the printing.

        == Printings
        num_printings: Type: integer
        Count of unique printings for this card.

        is_latest_printing: Type: boolean
        Is this printing the latest printing for a card?

        position: Type: integer
        The position of the printing in a card set.

        quantity, y: Type: integer
        The number of copies of a printing in the set.

        == Formats & Card Pools
        format: Type: array
        format_id for any format containing the card at any time.

        card_pool, z: Type: array
        card_pool_ids for a card pool containing a card.

        snapshot: Type: array
        snapshot_id of a snapshot containing a card.

        == Restrictions
        restriction_id, b: Type: array
        restriction_id specifying the card for any reason, like: restriction_id:eternal_points_list_22_09

        eternal_points: Type: array
        Concatenation of restriction_id and an Eternal Points value, joined by a hyphen, like eternal_points:eternal_points_list_22_09-2.

        has_global_penalty: Type: array
        restriction_id restricting the card with a global penalty, like has_global_penalty:napd_mwl_1_1.

        is_banned: Type: array
        restriction_id specifying the card as banned, like is_banned:standard_ban_list_22_08.

        is_restricted: Type: array
        restriction_id specifying the card as banned, like is_restricted:standard_mwl_3_4_b.

        in_restriction: Type: boolean
        Is the card specified on any Restriction list?

        universal_faction_cost: Type: array
        Concatenation of restriction_id and a Universal Faction Cost value, joined by a hyphen, like universal_faction_cost:napd_mwl_1_2-3.

        </pre>
      </form>
    </div>
  </template>
}
