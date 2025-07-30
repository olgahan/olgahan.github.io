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

  {% if pub.abstract %}
  <details style="display:inline-block; margin-right: 10px;">
    <summary style="display:inline; cursor:pointer; font-size: 0.9em;">Abstract</summary>
    <p style="margin: 0.5em 0 0 1.2em; max-width: 800px;">{{ pub.abstract }}</p>
  </details>
  {% endif %}
  
  {% if pub.link %}
  [{{ pub.link_label | default: "PDF" }}]({{ pub.link }})
  {% endif %}

  <br><br>
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% assign coauthors_clean = wp.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} (with {{ coauthors_clean }}){% endif %}
  {% if wp.year %} ({{ wp.year }}){% endif %}  

  {% if wp.abstract %}
  <details style="display:inline-block; margin-right: 10px;">
    <summary style="display:inline; cursor:pointer; font-size: 0.9em;">Abstract</summary>
    <p style="margin: 0.5em 0 0 1.2em; max-width: 800px;">{{ wp.abstract }}</p>
  </details>
  {% endif %}
  
  {% if wp.link %}
  [{{ wp.link_label | default: "Draft" }}]({{ wp.link }})
  {% endif %}
  
  <br><br>
{% endfor %}
