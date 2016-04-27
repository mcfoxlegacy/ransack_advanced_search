module RansackAdvancedSearchHelper
  def setup_search_form(builder)
    fields = builder.grouping_fields builder.object.new_grouping,
      object_name: 'new_object_name', child_index: "new_grouping" do |f|
      render('ransack_advanced_search/grouping_fields', f: f)
    end
    content_for :ransack_setup, %Q{
      var search = new Search({grouping: "#{escape_javascript(fields)}"});
      $(document).on("click", "button.add_fields", function() {
        search.add_fields(this, $(this).data('fieldType'), $(this).data('content'));
        return false;
      });
      $(document).on("click", "i.remove_fields", function() {
        search.remove_fields(this);
        return false;
      });
      $(document).on("click", "button.nest_fields", function() {
        search.nest_fields(this, $(this).data('fieldType'));
        return false;
      });
    }.html_safe
  end

  def button_to_remove_fields
    content_tag :i, nil, class: 'remove_fields glyphicon glyphicon-remove text-danger'
  end

  def button_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: "new_#{type}") do |builder|
      render('ransack_advanced_search/' + type.to_s + "_fields", f: builder)
    end
    content_tag :button, name, :class => 'add_fields btn btn-default btn-sm', :type => 'button', 'data-field-type' => type, 'data-content' => "#{fields}"
  end

  def button_to_nest_fields(name, type)
    content_tag :button, name, :class => 'nest_fields', 'data-field-type' => type
  end
end
