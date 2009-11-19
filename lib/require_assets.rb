module RequireAssets
  module Helpers
    # :section: External JavaScript and Stylesheets
    #
    # You can use require_js(:prototype) or require_css(:shinystyles)
    # from any view or layout, and the scripts will only be included once
    # in the head of the final page. To get this effect, the head of your
    # layout you will need to include a call to include_required_js and
    # include_required_css.
    #
    # ==== Examples
    # # File: app/views/layouts/application.html.erb
    #
    # <html>
    # <head>
    # <%= include_required_js %>
    # <%= include_required_css %>
    # </head>
    # <body>
    # <%= yield %>
    # </body>
    # </html>
    #
    # # File: app/views/whatever/index.html.erb
    #
    # <% require_js 'this' -%>
    # <% require_css 'that', 'another_one' -%>
    #
    # # Will generate the following in the final page...
    # <html>
    # <head>
    # <script src="/javascripts/this.js" type="text/javascript"></script>
    # <script src="/javascripts/something_else.js" type="text/javascript"></script>
    # <link href="/stylesheets/that.css" media="all" rel="Stylesheet" type="text/css"/>
    # <link href="/stylesheets/another_one.css" media="all" rel="Stylesheet" type="text/css"/>
    # </head>
    # .
    # .
    # .
    # </html>
    #
    def require_js(*js)
      @required_js ||= []
      @required_js |= js
    end
  
    # The require_css method can be used to require any CSS file anywhere in
    # your templates. Regardless of how many times a single stylesheet is
    # included with require_css, Merb will only include it once in the header.
    #
    # ==== Parameters
    # *css<~to_s>:: CSS files to include.
    #
    # ==== Examples
    # <% require_css('style') %>
    # # A subsequent call to include_required_css will render...
    # # => <link href="/stylesheets/style.css" media="all" rel="Stylesheet" type="text/css"/>
    #
    # <% require_css('style', 'ie-specific') %>
    # # A subsequent call to include_required_css will render...
    # # => <link href="/stylesheets/style.css" media="all" rel="Stylesheet" type="text/css"/>
    # # <link href="/stylesheets/ie-specific.css" media="all" rel="Stylesheet" type="text/css"/>
    #
    def require_css(*css)
      @required_css ||= []
      @required_css |= css
    end
    
    # A method used in the layout of an application to create +<script>+ tags
    # to include JavaScripts required in in templates and subtemplates using
    # require_js.
    #
    # ==== Returns
    # String:: The JavaScript tag.
    #
    # ==== Examples
    # # my_action.herb has a call to require_js 'jquery'
    # # File: layout/application.html.erb
    # include_required_js
    # # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    #
    # # my_action.html.erb has a call to require_js 'jquery', 'effects', 'validation'
    # # File: layout/application.html.erb
    # include_required_js
    # # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    # # <script src="/javascripts/effects.js" type="text/javascript"></script>
    # # <script src="/javascripts/validation.js" type="text/javascript"></script>
    #
    def include_required_js
      return '' if @required_js.nil?
      javascript_include_tag(*@required_js)
    end
    
    # A method used in the layout of an application to create +<link>+ tags for
    # CSS stylesheets required in in templates and subtemplates using
    # require_css.
    #
    # ==== Returns
    # String:: The CSS tag.
    #
    # ==== Examples
    # # my_action.herb has a call to require_css 'style'
    # # File: layout/application.html.erb
    # include_required_css
    # # => <link href="/stylesheets/style.css" media="all" rel="Stylesheet" type="text/css"/>
    #
    # # my_action.herb has a call to require_js 'style', 'ie-specific'
    # # File: layout/application.html.erb
    # include_required_css
    # # => <link href="/stylesheets/style.css" media="all" rel="Stylesheet" type="text/css"/>
    # # <link href="/stylesheets/ie-specific.css" media="all" rel="Stylesheet" type="text/css"/>
    #
    def include_required_css
      return '' if @required_css.nil?
      stylesheet_link_tag(*@required_css)
    end  
  end
end
