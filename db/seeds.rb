# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Category.delete_all
Classified.delete_all
# Country.delete_all
Currency.delete_all
Attachment.delete_all

qatar = Country.find_or_create_by_name_and_short_name(name: "Qatar", short_name: "Qt");
egypt = Country.find_or_create_by_name_and_short_name(name: "Egypt", short_name: "eg");
ksa = Country.find_or_create_by_name_and_short_name(name: "kingdom of saudia arabia", short_name: "KSA");

qar = Currency.create(name:"QAR", ratio: "0.325", country_id: qatar.id)
egp = Currency.create(name:"Egyptian pound", ratio: "0.103", country_id: egypt.id)
rial = Currency.create(name:"Rial", ratio: "0.325", country_id: ksa.id)

admin = User.new(name: 'Admin', phone: '01117761191',
 country_id: qatar.id, email: 'admin1@888.com')
admin.type = 'Admin'
admin.password = 'admin1'
admin.save

member = User.new(name: 'Member', phone: '01005647892',
 country_id: egypt.id, email: 'member1@888.com')
member.password = 'member1'
member.save

cars = Category.create(name: 'cars')
phones = Category.create(name: 'phones')
bmw = Category.create(name: 'bmw', parent_id: cars.id)
toyota = Category.create(name: 'toyota', parent_id: cars.id)
samsung = Category.create(name: 'samsung', parent_id: phones.id)
blackberry = Category.create(name: 'BlackBerry', parent_id: phones.id)

c1=Classified.new(title: 'samsung phone needed', kind:'Wanted', 
	country_id: qatar.id, price: 1025.32,
	currency_id: qar.id, main_category_id: phones.id,
	sub_category_id: samsung.id)
c2=Classified.new(title: 'blackberry phone needed', kind:'Wanted', 
	country_id: egypt.id, price: 1025.32,
	currency_id: egp.id, main_category_id: phones.id,
	sub_category_id: blackberry.id)
c3=Classified.new(title: 'BMW car', kind:'For Sale', 
	country_id: ksa.id, price: 120000,
	currency_id: rial.id, main_category_id: cars.id,
	sub_category_id: bmw.id)
c4=Classified.new(title: 'TOYOTA car needed', kind:'Wanted', 
	country_id: egypt.id, price: 85000,
	currency_id: egp.id, main_category_id: cars.id,
	sub_category_id: toyota.id)

c1.user = admin
c3.user = admin

c2.user = member
c4.user = member

c1.save
c2.save
c3.save
c4.save