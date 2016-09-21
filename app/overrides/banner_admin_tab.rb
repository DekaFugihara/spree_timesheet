Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "timesheet_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<ul class='nav nav-sidebar'><%= tab(:time_sheets, :icon => 'time', :label => 'Ponto', :url => spree.new_admin_time_sheet_path) %></ul>")