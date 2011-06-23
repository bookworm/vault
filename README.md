# Meet The Idea Vault.

The Idea Vault is essentially a place for my stuff. Its a very nice interface to all my creations & documents; my tasks, ideas, bookmarks, blog posts etc.  

Its kind like a tumblr if it was accidently bitten by a radioactive spider, or zapped with a radiation from a malfunctioning device in a laboratory, or hit by a radioactive meteorite, maybe a radioactive ring, or some radioactive goo fell on its head. Okay you get the point, its like a over cliche super hero created by Joseph Campbell.  

Its very flexible and designed to grow quickly with me as I need new features. Like say if one day instead of simple task list I want to push in a reading list; it shouldn't take me hours to add the feature.

So its got in a nutshell.

## 1. A simple API for adding content.      

No fancy backend sorry :( . If you'd like a backend then Padrino's scaffolding features should get you 75% of the way.
For me I plan to release and build desktop apps and then push them to this web app. 
Those apps will be open source as well, don't worry.                    

## 2. Nesting & flexible documents.       

Lets illustrate this with one of those fancy written examples I'm consistently seeing these days [^1].             

For the sake of our purposes lets imagine your a famous author with troves of groupies. Are you imagining?
One day you decide to make you need to add a list of some other less awesome books by less awesome authors that you enjoy
reading so you can sleep calmly knowing how much better you are.   

The first thing you do is create your self a nice task model. 

```ruby
class Task < Document    
  include MongoMapper::Document    
  
  # Keys
  key :completed, Boolean
  # more keys. followed by more code.
end   
```     

Then you create a book model and inherit the task model, thus genrating a book task model.

```ruby
class Booktask < Task
  include MongoMapper::Document  
  
  # Book Keys.  
end   
```  

But wait what if we want to add books but not have them be tasks? Do we violate the DRY Gods by adding a separate book model [^2]? No, we just get creative and use mixins.    

```ruby
module MongoMapperExt
  module Book 
    def self.included(klass)
      klass.class_eval do       
       # Book keys
      end
    end 
  end
end         
```
   
```ruby
class Book < Document      
  include MongoMapper::Document
  include MongoMapperExt::Book 
end     

class BookTask < Task  
  include MongoMapper::Document
  include MongoMapperExt::Book 
end
```                                                    

No we can use this anywhere and awesomely enough with the nesting features of the core Document class. We do this.      

```ruby
task_list = Document.new(:title => 'Task List')
task_list.add_task(:title => task)
task_list.add_booktask(:title => 'The Hero With A Thousand Faces')
```        

More later there is something shiny outside... Ah fuck, its the sun!

### Footnotes
1. *I'm 5,000 years old so written examples are relatively new to me. Back in the day we'd illustrate things visually by
  using religious minorities as forced example actors. Yeah those were the days.*           
2. *The DRY Gods were those who lived on Mount Olympus and thus avoided much of the excess precipitation resulting from many
  the Gods constant enjoyment of Mountain water skiing. The used to fight for the NO WATER rights but got tired of reapeating
  themselves* 
  
# Config/Setup.

Set the following ENV vars. I typically add ENV vars to config/heroku_env.rb then load it if it exists in config/boot.rb
```ruby
ENV['APP_DOMAIN_NAME'] = ""  
```   
 
If your going to add movies set your [tmdb](http://themoviedb.org) API key.     
```ruby
ENV["TMDB_API_KEY"] = ''     
``` 

# License

Copyright (C) 2011 Ken Erickson AKA Bookworm. (http://bookwormproductions.net)

## Media License.    
 
You do not receive any rights to use the fonts, images or videos. 
These are for example purposes only and you must replace them.    
You may not use any of the fonts, images, or videos on any site without permission. 

Also please be reasonable with your css usage i.e don't just swap-out graphics.

## All Source Code Is Licensed under WTFPL.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 3, August 2010. 
 
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
  0. Do Not Claim Authorship Of Code You Did Not Author.
  1. Do Not Use The Same Name As The Original Project.
  2. Beyond That, You just DO WHAT THE FUCK YOU WANT TO.