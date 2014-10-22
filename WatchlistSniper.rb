require 'watir-webdriver'

$browser = Watir::Browser.new :chrome
$browser.window.maximize
$browser.goto('http://elion.psu.edu')

$browser.link(text: 'Student').click

# initial login
$browser.text_field(id: 'login').set($username)
$browser.text_field(id: 'password').set($password)
$browser.button(value: 'Log In').click

begin # Select the Menu if the browser window isn't fullscreen
	$browser.div(class: 'container').link(class: 'btn btn-navbar dark addMarginsAll').click
rescue
end

# select Drop/Add from the Schedule dropdown
$browser.link(id: 'ScheduleCategoryDiv').click
$browser.link(id: 'allListForm:cats:8:functions:7:j_idt45').click

# select the Fall semester
# $browser.iframe(id: 'iframe').table(id: 'vwtable').radio(id: 'radio1@1').set

# select the Spring semester
$browser.iframe(id: 'iframe').table(id: 'vwtable').radio(id: 'radio1@2').set
$browser.iframe(id: 'iframe').button(value: 'Continue').click

# re-enter password
$browser.iframe(id: 'iframe').text_field(type: 'password').set($password)
$browser.iframe(id: 'iframe').button(value: '   OK   ').click

# add course to schedule
$browser.iframe(id: 'iframe').text_field(value: '').set($course_number)
$browser.iframe(id: 'iframe').button(value: 'Add course to schedule').click