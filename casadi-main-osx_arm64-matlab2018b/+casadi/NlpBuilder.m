classdef  NlpBuilder < casadi.PrintableCommon
    %NLPBUILDER [INTERNAL] 
    %
    %
    %A symbolic NLP representation.
    %
    %Joel Andersson
    %
    %::
    %
    %  Extra doc: https://github.com/casadi/casadi/wiki/L_1e2 
    %  
    %
    %
    %
    %C++ includes: nlp_builder.hpp
    %
    %
  methods
    function v = x(self)
      v = casadiMEX(1051, self);
    end
    function v = f(self)
      v = casadiMEX(1052, self);
    end
    function v = g(self)
      v = casadiMEX(1053, self);
    end
    function v = x_lb(self)
      v = casadiMEX(1054, self);
    end
    function v = x_ub(self)
      v = casadiMEX(1055, self);
    end
    function v = g_lb(self)
      v = casadiMEX(1056, self);
    end
    function v = g_ub(self)
      v = casadiMEX(1057, self);
    end
    function v = x_init(self)
      v = casadiMEX(1058, self);
    end
    function v = lambda_init(self)
      v = casadiMEX(1059, self);
    end
    function v = discrete(self)
      v = casadiMEX(1060, self);
    end
    function varargout = import_nl(self,varargin)
    %IMPORT_NL [INTERNAL] 
    %
    %  IMPORT_NL(self, char filename, struct opts)
    %
    %Import an .nl file.
    %
    %Doc source: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L75
    %
    %Implementation: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.cpp#L33-L36
    %
    %
    %
      [varargout{1:nargout}] = casadiMEX(1061, self, varargin{:});
    end
    function varargout = type_name(self,varargin)
    %TYPE_NAME [INTERNAL] 
    %
    %  char = TYPE_NAME(self)
    %
    %Readable name of the class.
    %
    %Doc source: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L78
    %
    %Implementation: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L78-L78
    %
    %
    %
      [varargout{1:nargout}] = casadiMEX(1062, self, varargin{:});
    end
    function varargout = disp(self,varargin)
    %DISP [INTERNAL] 
    %
    %  std::ostream & = DISP(self, bool more)
    %
    %Print a description of the object.
    %
    %Doc source: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L81
    %
    %Implementation: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.cpp#L38-L46
    %
    %
    %
      [varargout{1:nargout}] = casadiMEX(1063, self, varargin{:});
    end
    function varargout = str(self,varargin)
    %STR [INTERNAL] 
    %
    %  char = STR(self, bool more)
    %
    %Get string representation.
    %
    %Doc source: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L84
    %
    %Implementation: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/nlp_builder.hpp#L84-L88
    %
    %
    %
      [varargout{1:nargout}] = casadiMEX(1064, self, varargin{:});
    end
    function self = NlpBuilder(varargin)
    %NLPBUILDER 
    %
    %  new_obj = NLPBUILDER()
    %
    %
      self@casadi.PrintableCommon(SwigRef.Null);
      if nargin==1 && strcmp(class(varargin{1}),'SwigRef')
        if ~isnull(varargin{1})
          self.swigPtr = varargin{1}.swigPtr;
        end
      else
        tmp = casadiMEX(1065, varargin{:});
        self.swigPtr = tmp.swigPtr;
        tmp.SwigClear();
      end
    end
    function delete(self)
        if self.swigPtr
          casadiMEX(1066, self);
          self.SwigClear();
        end
    end
  end
  methods(Static)
  end
end
