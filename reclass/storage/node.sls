{%- from "reclass/map.jinja" import storage with context %}
{%- if storage.enabled %}

{{ storage.base_dir }}/nodes/_generated:
  file.directory

{%- for node_name, node in storage.node.iteritems() %}

{{ storage.base_dir }}/nodes/_generated/{{ node.name }}{%- if node.domain != "" %}.{{ node.domain }}{%- endif %}.yml:
  file.managed:
  - source: salt://reclass/files/node.yml
  - user: root
  - group: root
  - template: jinja
  - defaults:
      node_name: "{{ node_name }}"
{%- if storage.data_source.engine == "git" %}
  - requires:
    - git: {{ storage.data_source.address }}
{%- endif %}

{%- endfor %}

{%- endif %}