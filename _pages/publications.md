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
  <div style="margin-top: 0.25em; margin-bottom: 1em;">
    {% if pub.abstract %}
    <details style="display: inline-block; margin-right: 1em;">
      <summary style="cursor: pointer;">Abstract</summary>
      <p style="margin: 0.5em 0 0 0;">{{ pub.abstract }}</p>
    </details>
    {% endif %}
    {% if pub.link %}
    <a href="{{ pub.link }}">{{ pub.link_label | default: "PDF" }}</a>
    {% endif %}
  </div>
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
  <div style="margin-top: 0.25em; margin-bottom: 1em;">
    {% if wp.abstract %}
    <details style="display: inline-blo
