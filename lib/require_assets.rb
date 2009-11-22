module RequireAssets
  module Helpers
    # The require_js method can be used to require any JavaScript file anywhere in
    # your templates. Regardless of how many times a single script is included
    # with require_js, Rails will only include it once in the header.
    #
    # @param [#to_s] JavaScript files to include
    #
    # @example
    #   <% require_js('jquery') %>
    #   # A subsequent call to include_required_js will render...
    #   # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    #
    # @example
    #   <% require_js('jquery', 'effects', 'validation') %>
    #
    #   # A subsequent call to include_required_js will render...
    #   # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    #   #    <script src="/javascripts/effects.js" type="text/javascript"></script>
    #   #    <script src="/javascripts/validation.js" type="text/javascript"></script>
    #
    def require_js(*js)
      @required_js ||= []
      @required_js |= js
    end
  
    # The require_css method can be used to require any CSS file anywhere in
    # your templates. Regardless of how many times a single stylesheet is
    # included with require_css, Rails will only include it once in the header.
    #
    # @param [#to_s] CSS files to include
    #
    # @example
    #   <% require_css('style') %>
    #   # A subsequent call to include_required_css will render...
    #   # => <link href="/stylesheets/style.css" media="screen" rel="Stylesheet" type="text/css"/>
    #
    # @example
    #   <% require_css('style', 'ie-specific') %>
    #   # A subsequent call to include_required_css will render...
    #   # => <link href="/stylesheets/style.css" media="screen" rel="stylesheet" type="text/css"/>
    #   #    <link href="/stylesheets/ie-specific.css" media="screen" rel="stylesheet" type="text/css"/>
    #
    def require_css(*css)
      @required_css ||= []
      @required_css |= css
    end
    
    # A method used in the layout of an application to create +<script>+ tags
    # to include JavaScripts required in in templates and subtemplates using
    # require_js.
    #
    # @return [String] The JavaScript tag
    #
    # @example
    #   # my_action.html.erb has a call to require_js 'jquery'
    #   # File: layout/application.html.erb
    #   include_required_js
    #   # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    #
    # @example
    #   # my_action.html.erb has a call to require_js 'jquery', 'effects', 'validation'
    #   # File: layout/application.html.erb
    #   include_required_js
    #   # => <script src="/javascripts/jquery.js" type="text/javascript"></script>
    #   #    <script src="/javascripts/effects.js" type="text/javascript"></script>
    #   #    <script src="/javascripts/validation.js" type="text/javascript"></script>
    #
    def include_required_js
      return '' if @required_js.nil?
      javascript_include_tag(*@required_js)
    end
    
    # A method used in the layout of an application to create +<link>+ tags for
    # CSS stylesheets required in in templates and subtemplates using
    # require_css.
    #
    # @return [String] The CSS tag
    #
    # @example
    #   # my_action.html.erb has a call to require_css 'style'
    #   # File: layout/application.html.erb
    #   include_required_css
    #   # => <link href="/stylesheets/style.css" media="screen" rel="stylesheet" type="text/css"/>
    #
    # @example
    #   # my_action.html.erb has a call to require_js 'style', 'ie-specific'
    #   # File: layout/application.html.erb
    #   include_required_css
    #   # => <link href="/stylesheets/style.css" media="screen" rel="stylesheet" type="text/css"/>
    #        <link href="/stylesheets/ie-specific.css" media="screen" rel="stylesheet" type="text/css"/>
    #
    def include_required_css
      return '' if @required_css.nil?
      stylesheet_link_tag(*@required_css)
    end  
  end
end
