function varargout = difference(varargin)
    %DIFFERENCE \\bried Return all elements of a that do not occur in b, preserving 
    %
    %  {MX} = DIFFERENCE({MX} a, {MX} b)
    %
    %order
    %
    %Doc source: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/mx.hpp#L969
    %
    %Implementation: 
    %https://github.com/casadi/casadi/blob/main/casadi/core/mx.hpp#L969-L971
    %
    %
  [varargout{1:nargout}] = casadiMEX(964, varargin{:});
end
