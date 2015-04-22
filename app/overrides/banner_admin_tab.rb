Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "timesheet_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<%= tab(:time_sheets, :icon => 'icon-clock', :label => 'Ponto', :url => spree.new_admin_time_sheet_path) %>")