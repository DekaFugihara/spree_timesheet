Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "timesheet_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<ul class='nav nav-sidebar'><%= tab 'Ponto', url: spree.new_admin_time_sheet_path, icon: 'time' %></ul>",
                      :original => 'efc6f2099477786f7c0a90d890d990ad132d796b')