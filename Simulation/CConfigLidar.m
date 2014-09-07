classdef CConfigLidar
    %CConfigLidar Config class for Lidar object
    % This base class stores configuration parameters
    %   Constructor:
    %   config = CConfigLidar( N, FOVd, d_range, sd  )
    %
    % Adjustable parameters are those inputs in constructor:
    %   N - number of points in scan
    %   FOVd - Field Of View in degrees
    %   d_range - minimum and maximum distances to read
    %   sd - Standard Deviation (in [m]) of measurements
    %
    % Other accessible read-only parameters are:
    %   FOVr - Field Of View in radians
    %   d_min - minimum readable distance
    %   d_max - maximum readable distance
    
    properties (SetAccess = protected ) % Only changeable through constructor
        N       % Number of points
        FOVd    % Field Of View in degrees
        d_range % 1x2 Minimum and maximum ranges for measurements
        sd      % Standard Deviation in range measurements
    end
    
    properties (SetAccess = protected, Dependent)
        FOVr
        d_min
        d_max
    end
    
    properties (SetAccess = protected)
        theta
        dir
        lines
    end
    
    methods
        % Constructor
        function obj = CConfigLidar( N, FOVd, sd, d_range )
            obj.N  = N;
            obj.FOVd = FOVd;
            obj.sd = sd;
            obj.d_range = d_range;
            
            obj.theta = linspace( -deg2rad(FOVd)/2, +deg2rad(FOVd)/2, N );
            obj.dir   = [ cos( obj.theta )
                          sin( obj.theta ) ];
            obj.lines = [ [0 -1; 1 0] * obj.dir
                          zeros(1,N) ];
        end
        
        % Get vector of sampled angles
%         function theta = getSamplingAngles( obj )
%             theta = linspace( -obj.FOVr/2, +obj.FOVr/2, obj.N );
%         end
%         function dir = getSamplingVectors( obj )
%             vtheta = getSamplingAngles( obj );
%             dir    = [ cos( vtheta )
%                        sin( vtheta ) ];
%         end
%         function lines = getSamplingLines( obj )
%             dir   = getSamplingVectors( obj );
%             dir   = [0 -1; 1 0] * dir;
%             lines = [ dir
%                       zeros(1, obj.N) ];
%         end
        
        % Get methods
        function FOVr = get.FOVr(obj)
            FOVr  = deg2rad( obj.FOVd );
        end
        function d_min = get.d_min(obj)
            d_min = obj.d_range(1);
        end
        function d_max = get.d_max(obj)
            d_max = obj.d_range(2);
        end
    end
end