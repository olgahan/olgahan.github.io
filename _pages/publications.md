---
layout: page
permalink: /publications/
title: research
description: 
nav: true
nav_order: 2
---

---
layout: page
permalink: /publications/
title: research
description: 
nav: true
nav_order: 2
---

## Publications

<ul>
{% assign pubs = site.data.publications | where: "type", "publication" %}
{% for pub in pubs %}
  <li>
    <strong>{{ pub.title }}</strong>{% assign coauthors_clean = pub.coauthors | to_s | strip %}
    {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}, 
    <em>{{ pub.venue }}</em> ({{ pub.year }})

    {% if pub.abstract or pub.link %}
    <div style="display: inline-flex; gap: 1em; flex-wrap: wrap; margin: 0.2em 0 1em 0;">
      {% if pub.abstract %}
      <details style="display: inline-block;">
        <summary style="cursor: pointer;">Abstract</summary>
        <p style="margin: 0.5em 0 0 0;">{{ pub.abstract | markdownify }}</p>
      </details>
      {% endif %}
      {% if pub.link %}
      <a href="{{ pub.link }}">{{ pub.link_label | default: "PDF" }}</a>
      {% endif %}
    </div>
    {% endif %}
  </li>
{% endfor %}
</ul>

---


## Working Papers

<ul>
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
  <li>
    <strong>{{ wp.title }}</strong>{% assign coauthors_clean = wp.coauthors | to_s | strip %}
    {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}
    {% if wp.year %} ({{ wp.year }}){% endif %}

    {% if wp.abstract or wp.link %}
    <div style="display: inline-flex; gap: 1em; flex-wrap: wrap; margin: 0.2em 0 1em 0;">
      {% if wp.abstract %}
      <details style="display: inline-block;">
        <summary style="cursor: pointer;">Abstract</summary>
        <p style="margin: 0.5em 0 0 0;">{{ wp.abstract }}</p>
      </details>
      {% endif %}
      {% if wp.link %}
      <a href="{{ wp.link }}">{{ wp.link_label | default: "Draft" }}</a>
      {% endif %}
    </div>
    {% endif %}
  </li>
{% endfor %}
</ul>

