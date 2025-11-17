classdef  MetaCon < casadi.IndexAbstraction
    %METACON 
    %
    %   = METACON()
    %
    %
  methods
    function v = original(self)
      v = casadiMEX(1364, self);
    end
    function v = canon(self)
      v = casadiMEX(1365, self);
    end
    function v = type(self)
      v = casadiMEX(1366, self);
    end
    function v = lb(self)
      v = casadiMEX(1367, self);
    end
    function v = ub(self)
      v = casadiMEX(1368, self);
    end
    function v = n(self)
      v = casadiMEX(1369, self);
    end
    function v = flipped(self)
      v = casadiMEX(1370, self);
    end
    function v = dual_canon(self)
      v = casadiMEX(1371, self);
    end
    function v = dual(self)
      v = casadiMEX(1372, self);
    end
    function v = extra(self)
      v = casadiMEX(1373, self);
    end
    function v = linear_scale(self)
      v = casadiMEX(1374, self);
    end
    function self = MetaCon(varargin)
    %METACON 
    %
    %  new_obj = METACON()
    %
    %
      self@casadi.IndexAbstraction(SwigRef.Null);
      if nargin==1 && strcmp(class(varargin{1}),'SwigRef')
        if ~isnull(varargin{1})
          self.swigPtr = varargin{1}.swigPtr;
        end
      else
        tmp = casadiMEX(1375, varargin{:});
        self.swigPtr = tmp.swigPtr;
        tmp.SwigClear();
      end
    end
    function delete(self)
        if self.swigPtr
          casadiMEX(1376, self);
          self.SwigClear();
        end
    end
  end
  methods(Static)
  end
end
