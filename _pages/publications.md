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
  {% if pub.link %}[{{ pub.link_label | default: "PDF" }}]({{ pub.link }}){% endif %}

  {% if pub.abstract %}
  <details>
    <summary>Abstract</summary>
    <p>{{ pub.abstract }}</p>
  </details>
  {% endif %}
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% assign coauthors_clean = wp.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} (with {{ coauthors_clean }}){% endif %}
  {% if wp.year %} ({{ wp.year }}){% endif %}  
  {% if wp.link %}[{{ wp.link_label | default: "Draft" }}]({{ wp.link }}){% endif %}

  {% if wp.abstract %}
  <details>
    <summary>Abstract</summary>
    <p>{{ wp.abstract }}</p>
  </details>
  {% endif %}
{% endfor %}
