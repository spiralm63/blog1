Jane Scharankov
Socrates Challenge 289, Blog 1: Anonymous Blog

********* Scroll to end of document for instructions on Running the Application *********

Challenge Description:
      We're going to write a simple homepage with a blog.
      This will be our first many-to-many relationship inside the context of Sinatra.

      We'll have two core models: posts and tags.
      A post can have many tags and a tag can be on many posts.

Learning Goals:
      -- Many-to-many associations in ActiveRecord.
      -- How to use multiple files for controller routes.
      -- ActiveRecord validations.

Controllers & Routes:
      Think about your controllers and routes. Consider making three controller files:
          app/controllers/index.rb
          app/controllers/posts.rb
          app/controllers/tags.rb

          The index controller will just have the index route, displaying your homepage.
          All Post-related routes will go in the posts controller, and
          All Tag-related routes will go in the tags controller.

          These are the operations we want to support for posts:
            -- Show me all posts
            -- Show me a particular post
            -- Create a new post
            -- Edit an existing post
            -- Delete an existing post
            -- These are the operations we want to support for tags:
                        ** Show me all posts with a given tag
                        ** Tags will be created via the Post-creation form.

Models & Validations:
      You should have three models — what are they?

      Add the appropriate validations to your models.
          For example, if your Post model has body and title fields, you probably
              -- don't want to permit a Post that has no body or title to be saved to the database.
              -- This means adding NOT NULL constraints to the migrations and the following validations:

          class Post < ActiveRecord::Base
            validates :body, :presence => true
            validates :title, :presence => true
          end

      You'll have other fields and validations, to be sure.
      What fields do you want your blog post to have? Author?

Design Simple Pages and Forms:
      Design simple pages and forms to implement all the above functionality. It doesn't need to be styled well, but if your HTML is well-structured it will make it easier to style later.

      Your forms for creating and updating Post models should allow you to enter tags. You can decide how that works, although from a user experience perspective it would be incredibly tedious to have to create tags elsewhere before a post author can use them. However, if a post author uses a tag that already exists, you aren't going to want to create a new row in the tags table, but rather re-use the already-existing tag.

      One idea might be to permit them to enter tags like this:

      <label for="post_tags">Tags:</label>
      <input id="post_tags" name="post[tags]" value="tag1, tag2, some other tag, a fourth tag">
      which renders as:

      Tags:
        tag1, tag2, some other tag, a fourth tag

      All your routes should now implement their basic functionality. You should be able to list, show, create, update, and delete posts. You should also be able to see all posts for a given tag at a url like

      http://localhost:9393/tag/apple

Error Cases:
      Using valid? and invalid? and the errors methods, make sure you're handling your error cases gracefully. It doesn't need to be perfect, but good error handling means:

      1. When a user makes a mistake or breaks some rule, they're informed
      2. The user is presented with an opportunity to correct the mistake, if possible
      3. The user is given as much guidance as possible about that they need to do to fix the error


 *************************************

Steps I took to build and run this application:
(steps in parentheses were taken to create application: they create and
modify files. To run the application these steps do not need to be taken: the
files should be in their final needed form.)

run bundle
run rake db:create
    (If this command fails, you may need to rerun bundle as, bundle update. If the database exists, you
    may need to drop it to run it again: rake db:drop)

(((  The following commands create skeleton files that need to be amended:
    rake generate:model NAME=Tag
    rake generate:model NAME=Post
    rake generate:model NAME=PostTag
    rake generate:migration NAME=create_tags
    rake generate:migration NAME=create_posts
    rake generate:migration NAME=create_posts_tags
 )))

(((Now add field names to the migration files in db/migrate folder, and
    ActiveRecord relationships in the app/models folder )

      in create_posts.rb, add:
        create_table :posts do |t|
            t.string :title
            t.string :body
            t.timestamps
         end

      in create_tags.rb, add:
        create_table :tags do |t|
            t.string :tag_category
            t.timestamps
        end

      in create_posts_tags.rb, add:
        create_table :posts_tags do |t|
            t.integer :post_id
            t.integer :tag_id
            t.timestamps
        end

      in post.rb, add
        has_many :tags

        validates :body, :presence => true
        validates :title, :presence => true

      in tag.rb, add
        has_many :posts

      in post_tag.rb
        belongs_to :post
        belongs_to :tag

)))

run
    rake db:migrate

populate some dummy data using the seed file


