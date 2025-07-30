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
- **{{ pub.title }}**{% if pub.coauthors %} ({{ pub.coauthors }}){% endif %}, _{{ pub.venue }}_ ({{ pub.year }})  
  {% if pub.link %}[{{ pub.link_label | default: "PDF" }}]({{ pub.link }}){% endif %}
  {% if pub.abstract or pub.image %}
  <details>
    <summary>Show details</summary>
    {% if pub.abstract %}**Abstract:** {{ pub.abstract }}{% endif %}
    {% if pub.image %}<br><img src="{{ pub.image }}" alt="figure" style="max-width:100%; margin-top:10px;">{% endif %}
  </details>
  {% endif %}
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**{% if wp.coauthors %} ({{ wp.coauthors }}){% endif %} ({{ wp.year }})  
  {% if wp.link %}[{{ wp.link_label | default: "Draft" }}]({{ wp.link }}){% endif %}
  {% if wp.abstract or wp.image %}
  <details>
    <summary>Show details</summary>
    {% if wp.abstract %}**Abstract:** {{ wp.abstract }}{% endif %}
    {% if wp.image %}<br><img src="{{ wp.image }}" alt="figure" style="max-width:100%; margin-top:10px;">{% endif %}
  </details>
  {% endif %}
{% endfor %}
