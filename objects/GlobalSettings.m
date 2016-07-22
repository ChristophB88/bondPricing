classdef GlobalSettings < handle
    
    properties (SetAccess = immutable)
        %% date / calendar handling
       	DateFormat = 'yyyy-mm-dd';      % standard date format
        Holidays = holidays;            % defined holidays
        WeekdayConventions
    end
    
%    properties (Dependent)
%    end
    
     methods % Constructor
        function obj = GlobalSettings()
            obj.WeekdayConventions = GlobalSettings.getWeekdayConventions();
        end
     end

     %% dependent properties
     methods
         %% display method
         function disp(obj)
             disp('***********************************************');
             disp(['DateFormat:               ''', obj.DateFormat,'''']);
             disp(['Holidays:                 call to ''holidays()''']);
             disp(['WeekdayConventions:       look-up table']);
             disp('***********************************************');
         end
         
     end
     
     methods (Static)
         % get lookup table for weekday conventions
         function lookUp = getWeekdayConventions()
             % weekday names
             xxMonToSun = datenum('2016-07-18'):datenum('2016-07-24');
             shortNames = datestr(xxMonToSun, 'ddd');
             [~, longNames] = weekday(xxMonToSun, 'long');
             
             % weekday numeric code
             weekdayCode = [2:7, 1]';
             
             % weekend indicator
             weekend = [0 0 0 0 0 1 1]';
             
             % generate lookup table
             lookUp = table(longNames, shortNames, weekdayCode, weekend);
             lookUp.Properties.VariableNames = ...
                 {'weekday', 'weekdayShort', 'weekdayNum', 'weekendInd'};
             
         end
     end
end