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
  {% if coauthors_clean != "" %} (with {{ coauthors_clean }}){% endif %}, _{{ pub.venue }}_ ({{ pub.year }})

  {% if pub.abstract or pub.link %}
  &nbsp;&nbsp;
  {% if pub.abstract %}
  <details style="display: inline;">
    <summary style="display: inline; cursor: pointer;">Abstract</summary>
    <span style="display: none;">{{ pub.abstract }}</span>
  </details>
  {% endif %}
  {% if pub.link %}
  &nbsp;<a href="{{ pub.link }}">{{ pub.link_label | default: "PDF" }}</a>
  {% endif %}
  {% endif %}
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% assign coauthors_clean = wp.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} (with {{ coauthors_clean }}){% endif %}
  {% if wp.year %} ({{ wp.year }}){% endif %}

  {% if wp.abstract or wp.link %}
  &nbsp;&nbsp;
  {% if wp.abstract %}
  <details style="display: inline;">
    <summary style="display: inline; cursor: pointer;">Abstract</summary>
    <span style="display: none;">{{ wp.abstract }}</span>
  </details>
  {% endif %}
  {% if wp.link %}
  &nbsp;<a href="{{ wp.link }}">{{ wp.link_label | default: "Draft" }}</a>
  {% endif %}
  {% endif %}
{% endfor %}
