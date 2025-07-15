---
layout: page
permalink: /publications/
title: research
description: 
nav: true
nav_order: 2
---

<!-- _pages/publications.md -->
<div class="publications">

{% bibliography %}

</div>


# Publications

{% bibliography --filter='type:published' --sort=year desc %}

---

# Working Papers

{% bibliography --filter='type:working_paper' --sort=year desc %}
