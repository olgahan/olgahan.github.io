---
layout: page
permalink: /publications/
title: research
hide_title: true
description: 
nav: true
nav_order: 3
---

## Publications
{% assign pubs = site.data.publications | where: "type", "publication" %}
{% for pub in pubs %}
- **{{ pub.title }}**{% assign coauthors_clean = pub.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}
  {% if pub.year %} ({{ pub.year }}){% endif %}
  {% if pub.stage %}
    <span style="font-style: italic;">[{{ pub.stage }}]</span>
  {% endif %}

  {% if pub.abstract or pub.link %}
  <div style="display: flex; gap: 1em; align-items: flex-start; margin: 0.2em 0 1em 0; flex-wrap: wrap;">
    
    {% if pub.abstract %}
    <details style="display: inline-block;">
      <summary style="cursor: pointer;">Abstract</summary>
      <div style="margin-top: 0.5em;">
        {{ pub.abstract | markdownify }}
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
  {% if wp.stage %}
    <span style="font-style: italic;">[{{ wp.stage }}]</span>
  {% endif %}

  {% if wp.abstract or wp.link %}
  <div style="display: flex; gap: 1em; align-items: flex-start; margin: 0.2em 0 1em 0; flex-wrap: wrap;">
    
    {% if wp.abstract %}
    <details style="display: inline-block;">
      <summary style="cursor: pointer;">Abstract</summary>
      <div style="margin-top: 0.5em;">
        {{ wp.abstract | markdownify }}
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

---

## Work in Progress
{% assign wip = site.data.publications | where: "type", "wip" %}
{% for p in wip %}
- **{{ p.title }}**{% assign coauthors_clean = p.coauthors | to_s | strip %}
  {% if coauthors_clean != "" %} ({{ coauthors_clean }}){% endif %}
  {% if p.year %} ({{ p.year }}){% endif %}
  {% if p.stage %}
    <span style="font-style: italic;">[{{ p.stage }}]</span>
  {% endif %}

  {% if p.abstract or p.link %}
  <div style="display: flex; gap: 1em; align-items: flex-start; margin: 0.2em 0 1em 0; flex-wrap: wrap;">
    
    {% if p.abstract %}
    <details style="display: inline-block;">
      <summary style="cursor: pointer;">Abstract</summary>
      <div style="margin-top: 0.5em;">
        {{ p.abstract | markdownify }}
      </div>
    </details>
    {% endif %}

    {% if p.link %}
    <div style="display: inline-block;">
      <a href="{{ p.link }}">{{ p.link_label | default: "Draft" }}</a>
    </div>
    {% endif %}
  </div>
  {% endif %}
{% endfor %}
