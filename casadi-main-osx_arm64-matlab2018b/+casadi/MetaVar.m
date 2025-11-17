classdef  MetaVar < casadi.IndexAbstraction
    %METAVAR 
    %
    %   = METAVAR()
    %
    %
  methods
    function v = attribute(self)
      v = casadiMEX(1377, self);
    end
    function v = n(self)
      v = casadiMEX(1378, self);
    end
    function v = m(self)
      v = casadiMEX(1379, self);
    end
    function v = type(self)
      v = casadiMEX(1380, self);
    end
    function v = domain(self)
      v = casadiMEX(1381, self);
    end
    function v = count(self)
      v = casadiMEX(1382, self);
    end
    function v = i(self)
      v = casadiMEX(1383, self);
    end
    function v = active_i(self)
      v = casadiMEX(1384, self);
    end
    function v = extra(self)
      v = casadiMEX(1385, self);
    end
    function self = MetaVar(varargin)
    %METAVAR 
    %
    %  new_obj = METAVAR()
    %
    %
      self@casadi.IndexAbstraction(SwigRef.Null);
      if nargin==1 && strcmp(class(varargin{1}),'SwigRef')
        if ~isnull(varargin{1})
          self.swigPtr = varargin{1}.swigPtr;
        end
      else
        tmp = casadiMEX(1386, varargin{:});
        self.swigPtr = tmp.swigPtr;
        tmp.SwigClear();
      end
    end
    function delete(self)
        if self.swigPtr
          casadiMEX(1387, self);
          self.SwigClear();
        end
    end
  end
  methods(Static)
  end
end
