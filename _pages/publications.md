---
layout: page
permalink: /publications/
title: research
description: 
nav: true
nav_order: 2
---
<h2>Publications</h2>

<ul class="pub-list">
  {% for pub in site.data.publications %}
    {% if pub.type == "publication" %}
      <li>
        <strong>{{ pub.title }}</strong>
        {% if pub.coauthors %}<br><em>{{ pub.coauthors }}</em>{% endif %}
        <br>
        <em>{{ pub.venue }}</em>{% if pub.year %}, {{ pub.year }}{% endif %}
        {% if pub.volume %}, Vol. {{ pub.volume }}{% endif %}{% if pub.number %}({{ pub.number }}){% endif %}
        {% if pub.publisher %}, {{ pub.publisher }}{% endif %}
        <br>
        {% if pub.link %}
          <a href="{{ pub.link }}">{{ pub.link_label | default: "Link" }}</a>
        {% endif %}
        {% assign has_abstract = pub.abstract %}
        {% assign has_image = pub.image %}
        {% if has_abstract or has_image %}
          <button onclick="toggleDetails(this)">Show More</button>
          <div class="details" style="display: none; margin-top: 0.5em;">
            {% if has_abstract %}
              <p><strong>Abstract:</strong> {{ pub.abstract }}</p>
            {% endif %}
            {% if has_image %}
              <img src="{{ pub.image }}" alt="Figure" style="max-width: 100%; margin-top: 1em;">
            {% endif %}
          </div>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>

<h2>Working Papers</h2>

<ul class="pub-list">
  {% for wp in site.data.publications %}
    {% if wp.type == "working-paper" %}
      <li>
        <strong>{{ wp.title }}</strong>
        {% if wp.coauthors %}<br><em>{{ wp.coauthors }}</em>{% endif %}
        {% if wp.note %}<br><em>{{ wp.note }}</em>{% endif %}
        <br>
        {% if wp.link %}
          <a href="{{ wp.link }}">{{ wp.link_label | default: "Link" }}</a>
        {% endif %}
        {% assign has_abstract = wp.abstract %}
        {% assign has_image = wp.image %}
        {% if has_abstract or has_image %}
          <button onclick="toggleDetails(this)">Show More</button>
          <div class="details" style="display: none; margin-top: 0.5em;">
            {% if has_abstract %}
              <p><strong>Abstract:</strong> {{ wp.abstract }}</p>
            {% endif %}
            {% if has_image %}
              <img src="{{ wp.image }}" alt="Figure" style="max-width: 100%; margin-top: 1em;">
            {% endif %}
          </div>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>

<script>
function toggleDetails(button) {
  const details = button.nextElementSibling;
  if (details.style.display === "none") {
    details.style.display = "block";
    button.textContent = "Hide";
  } else {
    details.style.display = "none";
    button.textContent = "Show More";
  }
}
</script>
