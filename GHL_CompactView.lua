--[[ 
Version 1.0
]]--
function MainCompactView()
	local stateCompactView = false

	function StateCompactCEWindow(state)
		stateCompactView = state
		local controlMainForm = getMainForm()
		local separator = controlMainForm.getControl(0)
		local Panel1 = controlMainForm.getControl(1)
		local Panel4 = controlMainForm.getControl(2)
		local Panel5 = controlMainForm.getControl(3)

		separator.setVisible( state)
		Panel4.setVisible(state)
		Panel5.setVisible(state)
	end

	function CompactCEWindow()
		menuItem_setCaption(newItem1, 'Compact View')
		menuItem_onClick(newItem1, UnCompactCEWindow)
		StateCompactCEWindow(true)
		getMainForm().Height = 600
	end

	function UnCompactCEWindow()
		menuItem_setCaption(newItem1, 'Full View')
		menuItem_onClick(newItem1, CompactCEWindow)
		StateCompactCEWindow(false)
		getMainForm().Height = 300
	end
	
	
	

	------------
	local menuItem = menu_getItems(form_getMenu(getMainForm()))
	newItem1 = createMenuItem(menuItem)
	menuItem_add(menuItem, newItem1)

	local classSettingsCommpactView = ClassSettings:New('userdata.txt', '*.txt')
	local mainForm =  getMainForm()
	local lastDestroy = mainForm.OnDestroy
	mainForm.OnDestroy = function (sender)
			
		if(stateCompactView) then
			classSettingsCommpactView:Set('compactView', '1')
		else
			classSettingsCommpactView:Set('compactView', '0')
		end
		classSettingsCommpactView:SaveForm(mainForm, 'CEForm')
		classSettingsCommpactView:Save()
		lastDestroy()
	end

	if(classSettingsCommpactView:Get('compactView', '0') == '1') then
		CompactCEWindow()
	else
		UnCompactCEWindow()
	end
	
	classSettingsCommpactView:LoadForm(mainForm, 'CEForm')
end

MainCompactView()

