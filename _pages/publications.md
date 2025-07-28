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
- **{{ pub.title }}**, {{ pub.authors }}, _{{ pub.venue }}_ ({{ pub.year }})  
  {% if pub.link %}[{{ pub.link_label | default: "PDF" }}]({{ pub.link }}){% endif %}
{% endfor %}

---

## Working Papers
{% assign wps = site.data.publications | where: "type", "working-paper" %}
{% for wp in wps %}
- **{{ wp.title }}**, {{ wp.authors }} ({{ wp.year }})  
  {% if wp.link %}[{{ wp.link_label | default: "Draft" }}]({{ wp.link }}){% endif %}
{% endfor %}
