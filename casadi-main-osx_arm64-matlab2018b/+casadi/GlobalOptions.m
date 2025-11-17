classdef  GlobalOptions < SwigRef
    %GLOBALOPTIONS [INTERNAL] 
    %
    %
    %Collects global CasADi options.
    %
    %Note to developers: 
    %use sparingly. Global options are - in general - a 
    %rather bad idea
    %
    %this class must never be instantiated. Access its static members 
    %directly 
    %
    %Joris Gillis
    %
    %Extra doc: https://github.com/casadi/casadi/wiki/L_23m
    %
    %C++ includes: global_options.hpp
    %
    %
  methods
    function this = swig_this(self)
      this = casadiMEX(3, self);
    end
    function self = GlobalOptions(varargin)
    %GLOBALOPTIONS 
    %
    %  new_obj = GLOBALOPTIONS()
    %
    %
      if nargin==1 && strcmp(class(varargin{1}),'SwigRef')
        if ~isnull(varargin{1})
          self.swigPtr = varargin{1}.swigPtr;
        end
      else
        tmp = casadiMEX(1022, varargin{:});
        self.swigPtr = tmp.swigPtr;
        tmp.SwigClear();
      end
    end
    function delete(self)
        if self.swigPtr
          casadiMEX(1023, self);
          self.SwigClear();
        end
    end
  end
  methods(Static)
    function varargout = setSimplificationOnTheFly(varargin)
    %SETSIMPLIFICATIONONTHEFLY 
    %
    %  SETSIMPLIFICATIONONTHEFLY(bool flag)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1008, varargin{:});
    end
    function varargout = getSimplificationOnTheFly(varargin)
    %GETSIMPLIFICATIONONTHEFLY 
    %
    %  bool = GETSIMPLIFICATIONONTHEFLY()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1009, varargin{:});
    end
    function varargout = setHierarchicalSparsity(varargin)
    %SETHIERARCHICALSPARSITY 
    %
    %  SETHIERARCHICALSPARSITY(bool flag)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1010, varargin{:});
    end
    function varargout = getHierarchicalSparsity(varargin)
    %GETHIERARCHICALSPARSITY 
    %
    %  bool = GETHIERARCHICALSPARSITY()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1011, varargin{:});
    end
    function varargout = setCasadiPath(varargin)
    %SETCASADIPATH 
    %
    %  SETCASADIPATH(char path)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1012, varargin{:});
    end
    function varargout = getCasadiPath(varargin)
    %GETCASADIPATH 
    %
    %  char = GETCASADIPATH()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1013, varargin{:});
    end
    function varargout = setCasadiIncludePath(varargin)
    %SETCASADIINCLUDEPATH 
    %
    %  SETCASADIINCLUDEPATH(char path)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1014, varargin{:});
    end
    function varargout = getCasadiIncludePath(varargin)
    %GETCASADIINCLUDEPATH 
    %
    %  char = GETCASADIINCLUDEPATH()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1015, varargin{:});
    end
    function varargout = setMaxNumDir(varargin)
    %SETMAXNUMDIR 
    %
    %  SETMAXNUMDIR(int ndir)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1016, varargin{:});
    end
    function varargout = getMaxNumDir(varargin)
    %GETMAXNUMDIR 
    %
    %  int = GETMAXNUMDIR()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1017, varargin{:});
    end
    function varargout = setCopyElisionMinSize(varargin)
    %SETCOPYELISIONMINSIZE 
    %
    %  SETCOPYELISIONMINSIZE(int sz)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1018, varargin{:});
    end
    function varargout = getCopyElisionMinSize(varargin)
    %GETCOPYELISIONMINSIZE 
    %
    %  int = GETCOPYELISIONMINSIZE()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1019, varargin{:});
    end
    function varargout = setTempWorkDir(varargin)
    %SETTEMPWORKDIR 
    %
    %  SETTEMPWORKDIR(char dir)
    %
    %
     [varargout{1:nargout}] = casadiMEX(1020, varargin{:});
    end
    function varargout = getTempWorkDir(varargin)
    %GETTEMPWORKDIR 
    %
    %  char = GETTEMPWORKDIR()
    %
    %
     [varargout{1:nargout}] = casadiMEX(1021, varargin{:});
    end
  end
end
