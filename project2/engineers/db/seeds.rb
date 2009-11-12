# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

p1 = Project.create(:name => 'Windows', :description => 'Ancient Operating Ssytem') 
p2 = Project.create(:name => 'Linux', :description => 'A Good Choice') 
p3 = Project.create(:name => 'Mac OS/X', :description => 'Works Best')

# Skill Levels
SkillLevel.create(:name => 'Intern', 
    :description => 'An intern is one who works in a temporary position with an emphasis on on-the-job training rather than merely employment, making it similar to an apprenticeship.')
SkillLevel.create(:name => 'Developer (supervised)', 
    :description => 'A supervised developer is a person or organization concerned with facets of the software development process wider than design and coding, a somewhat broader scope of computer programming or a specialty of project managing including some aspects of software product management.')
SkillLevel.create(:name => 'Developer (independent)',
    :description =>  'An independent developer is a person or organization concerned with facets of the software development process wider than design and coding, a somewhat broader scope of computer programming or a specialty of project managing including some aspects of software product management.')
SkillLevel.create(:name => 'Technical Lead',
    :description => 'A Technical Lead is a software engineer in charge of one or more software projects.')
SkillLevel.create(:name => 'Project Lead',
    :description => 'A person who heads an information systems project.')
SkillLevel.create(:name => 'Expert',
    :description => 'Someone widely recognized as a reliable source of technique or skill whose faculty for judging or deciding rightly, justly, or wisely is accorded authority and status by their peers or the public in a specific well-distinguished domain.')

Scope.create(:name => 'Apprentice',
     :description => 'Someone who is learning a trade or occupation.')
Scope.create(:name => 'Developer',
     :description => 'A person or organization concerned with facets of the software development process wider than design and coding')
Scope.create(:name => 'Practicioner (Area Lead)',
     :description => 'Someone who practices a learned profession')
Scope.create(:name => 'Leader (Project Lead)',
     :description => 'A person who heads an IT project.')
Scope.create(:name => 'Master',
     :description => 'An artist of consummate skill.')

Organization.create(:name => 'ABC Company', :description => 'They like the alphabet.')
Organization.create(:name = 'JHU', :description => 'Johns Hopkins')
