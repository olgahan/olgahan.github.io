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

  <br>

  <span>
    {% if pub.abstract %}
    <details style="display: inline;">
      <summary style="display: inline; cursor: pointer;">Abstract</summary>
      <p style="margin-top: 0.5em;">{{ pub.abstract }}</p>
    </details>
    {% endif %}

    {% if pub.link %}
    <a href="{{ pub.link }}" style="margin-left: 1em;">
      {{ pub.link_label | default: "PDF" }}
    </a>
    {% endif %}
  </span>

  <br><br>
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% assign coauthors_clean = wp.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} (with {{ coauthors_clean }}){% endif %}
  {% if wp.year %} ({{ wp.year }}){% endif %}

  <br>

  <span>
    {% if wp.abstract %}
    <details style="display: inline;">
      <summary style="display: inline; cursor: pointer;">Abstract</summary>
      <p style="margin-top: 0.5em;">{{ wp.abstract }}</p>
    </details>
    {% endif %}

    {% if wp.link %}
    <a href="{{ wp.link }}" style="margin-left: 1em;">
      {{ wp.link_label | default: "Draft" }}
    </a>
    {% endif %}
  </span>

  <br><br>
{% endfor %}
