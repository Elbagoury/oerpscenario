# -*- encoding: utf-8 -*-
#################################################################################
#                                                                               #
#    OERPScenario, OpenERP Functional Tests                                     #
#    Copyright (C) 2011 Akretion Benoît Guillot <benoit.guillot@akretion.com>   #
#                                                                               #
#    This program is free software: you can redistribute it and/or modify       #
#    it under the terms of the GNU General Public License as published by       #
#    the Free Software Foundation, either version 3 Afero of the License, or    #
#    (at your option) any later version.                                        #
#                                                                               #
#    This program is distributed in the hope that it will be useful,            #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
#    GNU General Public License for more details.                               #
#                                                                               #
#    You should have received a copy of the GNU General Public License          #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.      #
#                                                                               #
#################################################################################
When /^I press the force_assign button$/ do
  @delivery_order.force_assign()
end

When /^I press the Process button$/ do
  @delivery_order.action_process()
  @delivery_order.validate_picking()
end

Then /^I should see the delivery order (.*)$/ do |state|
    @delivery_order = StockPicking.find(@delivery_order.id)
  if state == 'Ready To Process'
    @delivery_order.state.should == 'assigned'
  elsif state == 'Done'
    @delivery_order.state.should == 'done'
  end
end
