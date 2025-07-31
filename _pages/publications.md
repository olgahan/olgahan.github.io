---
layout: page
permalink: /publications/
title: research
description: 
nav: true
nav_order: 2
---

## Publications
{% assign pubs = site.data.publications | where: "type", "publication" %}
{% for pub in pubs %}
- **{{ pub.title }}**{% assign coauthors_clean = pub.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}, _{{ pub.venue }}_ ({{ pub.year }})

  {% if pub.abstract or pub.link %}
  <div style="display: flex; align-items: center; gap: 1em; flex-wrap: wrap; margin: 0.2em 0 0.5em 0;">
    {% if pub.abstract %}
    <details style="display: inline-block;">
      <summary style="cursor: pointer; margin: 0;">Abstract</summary>
      <div style="margin-top: 0.5em; max-width: 800px;">
        <p style="margin: 0;">{{ pub.abstract }}</p>
      </div>
    </details>
    {% endif %}
    {% if pub.link %}
    <div style="display: inline-block;">
      <a href="{{ pub.link }}">{{ pub.link_label | default: "PDF" }}</a>
    </div>
    {% endif %}
  </div>
  {% endif %}
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% assign coauthors_clean = wp.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}
  {% if wp.year %} ({{ wp.year }}){% endif %}

  {% if wp.abstract or wp.link %}
  <div style="display: flex; align-items: center; gap: 1em; flex-wrap: wrap; margin: 0.2em 0 0.5em 0;">
    {% if wp.abstract %}
    <details style="display: inline-block;">
      <summary style="cursor: pointer; margin: 0;">Abstract</summary>
      <div style="margin-top: 0.5em; max-width: 800px;">
        <p style="margin: 0;">{{ wp.abstract }}</p>
      </div>
    </details>
    {% endif %}
    {% if wp.link %}
    <div style="display: inline-block;">
      <a href="{{ wp.link }}">{{ wp.link_label | default: "Draft" }}</a>
    </div>
    {% endif %}
  </div>
  {% endif %}
{% endfor %}
