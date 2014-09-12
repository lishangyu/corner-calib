classdef CTrihedronObservation
    %CTrihedronObservation Class for storage of Camera and LRF data in a
    %frame
    %   Detailed explanation goes here
    
    properties
        % Camera properties
        cam_R_c_w   % 3(3x1) normals to World planes
        cam_A_R_c_w % 9x9 (rank 3) covariance matrix of R_c_w elements, groupable in 3x3 cell array
        cam_l       % 3(3x1) homogeneous lines in image (coincident with direction of normals to reprojection planes from camera center after normalization)
        cam_A_l     % TODO
        
        % LRF properties
        LRF_v       % 3(2x1) direction of scan segments
        LRF_A_v     % 3x3 (rank 3) minimal covariance matrix of v elements (covariance of angles)
        LRF_l       % 3(3x1) homogeneous lines in scan plane
        LRF_A_l     % TODO
        LRF_q       % 3(2x1) 2D intersection points of scan lines
        LRF_A_q     % TODO
        
        % Derived properties (existence of data)
        thereis_LRF_v   % 1x3 mask: is there measured direction for LRF in plane?
        thereis_LRF_q   % 1x3 mask: is there measured intersection for LRF in plane?
        complete_LRF    % Logical: is there all information of LRF?
        
        % Control of outliers
        is_R_outlier    % 1x3 mask: is the correspondence an outlier for Rotation?
        is_t_outlier    % 1x3 mask: is the correspondence an outlier for Translation?
    end
    
    methods
        function obj = CTrihedronObservation( cam_R_c_w, cam_A_R_c_w, cam_l, cam_A_l,...
                LRF_v, LRF_A_v, LRF_l, LRF_A_l, LRF_q, LRF_A_q )

            obj.cam_R_c_w = cam_R_c_w;
            obj.cam_A_R_c_w = cam_A_R_c_w;
            obj.cam_l = cam_l;
            obj.cam_A_l = cam_A_l;
            obj.LRF_v = LRF_v;
            obj.LRF_A_v = LRF_A_v;
            obj.LRF_l = LRF_l;
            obj.LRF_A_l = LRF_A_l;
            obj.LRF_q = LRF_q;
            obj.LRF_A_q = LRF_A_q;
            
            obj.thereis_LRF_v = cellfun(@(x)~isempty(x), obj.LRF_v);
            obj.thereis_LRF_q = cellfun(@(x)~isempty(x), obj.LRF_q);
            obj.complete_LRF  = all( obj.thereis_LRF_v ) && all( obj.thereis_LRF_q );
            
            obj.is_R_outlier = false(1,3); % Initially supposed all inliers
            obj.is_t_outlier = false(1,3); % Initially supposed all inliers
            
            % TODO: Add tracking information?
        end
    end
    
end
