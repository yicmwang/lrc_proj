classdef  Options < SwigRef
    %OPTIONS 
    %
    %   = OPTIONS()
    %
    %
  methods
    function this = swig_this(self)
      this = casadiMEX(3, self);
    end
    function varargout = all(self,varargin)
    %ALL 
    %
    %  {char} = ALL(self)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1237, self, varargin{:});
    end
    function varargout = type(self,varargin)
    %TYPE 
    %
    %  char = TYPE(self, char name)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1238, self, varargin{:});
    end
    function varargout = info(self,varargin)
    %INFO 
    %
    %  char = INFO(self, char name)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1239, self, varargin{:});
    end
    function varargout = suggestions(self,varargin)
    %SUGGESTIONS 
    %
    %  {char} = SUGGESTIONS(self, char word, int amount)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1241, self, varargin{:});
    end
    function varargout = best_matches(self,varargin)
    %BEST_MATCHES 
    %
    %  BEST_MATCHES(self, char word, std::vector< std::pair< double,std::string >,std::allocator< std::pair< double,std::string > > > & best)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1242, self, varargin{:});
    end
    function varargout = check(self,varargin)
    %CHECK 
    %
    %  CHECK(self, struct opts)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1247, self, varargin{:});
    end
    function varargout = print_all(self,varargin)
    %PRINT_ALL 
    %
    %  std::ostream & = PRINT_ALL(self)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1248, self, varargin{:});
    end
    function varargout = print_one(self,varargin)
    %PRINT_ONE 
    %
    %  std::ostream & = PRINT_ONE(self, char name)
    %
    %
      [varargout{1:nargout}] = casadiMEX(1249, self, varargin{:});
    end
    function self = Options(varargin)
    %OPTIONS 
    %
    %  new_obj = OPTIONS()
    %
    %
      if nargin==1 && strcmp(class(varargin{1}),'SwigRef')
        if ~isnull(varargin{1})
          self.swigPtr = varargin{1}.swigPtr;
        end
      else
        tmp = casadiMEX(1250, varargin{:});
        self.swigPtr = tmp.swigPtr;
        tmp.SwigClear();
      end
    end
    function delete(self)
        if self.swigPtr
          casadiMEX(1251, self);
          self.SwigClear();
        end
    end
  end
  methods(Static)
    function varargout = word_distance(varargin)
    %WORD_DISTANCE 
    %
    %  double = WORD_DISTANCE(char a, char b)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1240, varargin{:});
    end
    function varargout = has_dot(varargin)
    %HAS_DOT 
    %
    %  bool = HAS_DOT(struct opts)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1243, varargin{:});
    end
    function varargout = has_null(varargin)
    %HAS_NULL 
    %
    %  bool = HAS_NULL(struct opts)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1244, varargin{:});
    end
    function varargout = is_sane(varargin)
    %IS_SANE 
    %
    %  bool = IS_SANE(struct opts)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1245, varargin{:});
    end
    function varargout = sanitize(varargin)
    %SANITIZE 
    %
    %  struct = SANITIZE(struct opts, bool top_level)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1246, varargin{:});
    end
  end
end
