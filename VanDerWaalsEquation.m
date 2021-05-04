function [] = VanDerWaalsEquation()
    %defines  the constants and global variables
    global solver R a b;
    R = 8.314;
    a = 0;b = 0;
    
    %initializes figure
    solver.fig = figure;
    
    %creates the text and edit box so user can insert the critical
    %temperature needed
    solver.critTempEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.22 .805 .2 .05]);
    solver.critTempTextBox = uicontrol(solver.fig,'Style','text','units','normalized','position',[.02 .8 .2 .05],'String','Critical Temperature(K):');
    
    %creates the text and edit box so user can insert the critical pressure
    solver.critPressureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.7 .8 .2 .05]);
    solver.critPressureTextBox = uicontrol(solver.fig,'Style','text','units','normalized','position',[.4975 .795 .2 .05],'String','Critical Pressure(Pa):');
   
   
    %titles the pressure solver part
    solver.pressureTitle = uicontrol(solver.fig,'Style','text','units','normalized','position',[.1 .7 .2 .05],'String','To Solve for Pressure:');
    
    %creates the text and edit box so user can insert the specific volume
    %needed
    solver.volumeEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.19 .65 .2 .05]);
    solver.volumeText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.04 .63 .15 .075],'String','Specific Volume: (m^3/mol)');
     
    %creates the text and edit box so user can insert the temperature
    %needed
    solver.temperatureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.19 .55 .2 .05]);
    solver.temperatureText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.07 .52 .11 .075],'String','Temp(K):');

    %makes the button that starts the CalculatePressure function 
    solver.pressureCalculateButton = uicontrol(solver.fig,'Style','pushbutton','units','normalized','position',[.24 .47 .1 .05],'String','Calculate');
    solver.pressureCalculateButton.Callback=@CalculatePressure;
    
    %displays and titles the final pressure
    solver.finalPressureDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.01 .375 .2 .05],'String','Final Pressure(Pa):');
    solver.pressureValue = uicontrol(solver.fig,'Style','text','units','normalized','position',[.2 .375 .15 .05]);
    
    %gives a title to the temperature solving part
    solver.temperatureTitle = uicontrol(solver.fig,'Style','text','units','normalized','position',[.58 .7 .3 .05],'String','To Solve for Temperature:');
    
    solver.volume2EditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.71 .65 .2 .05]);
    solver.volume2Text = uicontrol(solver.fig,'Style','text','units','normalized','position',[.545 .63 .15 .075],'String','Specific Volume: (m^3/mol)');    
   
    %creates the text and edit box so that the user can enter the pressure
  
    solver.pressureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.71 .55 .2 .05]);
    solver.pressureText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.58 .52 .11 .075],'String','Pressure: (Pa)');
    
    %creates the calculate button that enables the function to occur
    solver.temperatureCalculateButton = uicontrol(solver.fig,'Style','pushbutton','units','normalized','position',[.76 .47 .1 .05],'String','Calculate');
    solver.temperatureCalculateButton.Callback=@CalculateTemperature;
    
    %displays and titles the final temperature
    solver.finalTemperatureDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.55 .375 .2 .05],'String','Final Temperature(K):');
    solver.temperatureValue = uicontrol(solver.fig,'Style','text','units','normalized','position',[.74 .375 .15 .05]);
    
    %displays the equation
    solver.EqDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.2 .1 .5 .2],'String','VanDerWaal Equation: P[V-b]V^2=RTV^2-a(V-b)');
    
    %takes in all inputed values from the pressure portion and solves the
    %equation
    function CalculatePressure(src,event)
    %gathers the input values from the critical temperature and pressure edit boxes
        solver.critTemp = get(solver.critTempEditBox,'String');
        solver.critPressure = get(solver.critPressureEditBox,'String');
    %gives an error messages with false inputs
        if isempty(str2num(solver.critPressureEditBox.String)) | str2num(solver.critPressureEditBox.String) < 0
            msgbox('Insert a valid critical pressure!');
        elseif isempty(str2num(solver.critTempEditBox.String)) | str2num(solver.critTempEditBox.String) < 0
            msgbox('Insert a valid critical temperature!');
        elseif isempty(str2num(solver.temperatureEditBox.String)) | str2num(solver.temperatureEditBox.String) < 0;
            msgbox('Insert a valid Temperature');
        elseif isempty(str2num(solver.volumeEditBox.String)) | str2num(solver.volumeEditBox.String) < 0;
            msgbox('Insert a valid Specific Volume');
        else
     %changes critTemp and critPressure from strings to numbers
            solver.critTemp = str2num(solver.critTemp);
            solver.critPressure = str2num(solver.critPressure);
            
     %solves the literal equation      
            a = (27*R^2*solver.critTemp^2)/(64*solver.critPressure);
            b = (R*solver.critTemp)/(8*solver.critPressure);
            
            specificVol = get(solver.volumeEditBox,'String');
            specificVol = str2num(specificVol);
            
            temperature = get(solver.temperatureEditBox,'String');
            temperature = str2num(temperature);
            
            pressure = ((R*temperature)/(specificVol-b))-(a/(specificVol)^2);
            set(solver.pressureValue,'String',num2str(pressure));
        end
    end
    
    function CalculateTemperature(src,event)
    %gets the values from the critical temperature and pressure edit boxes  
        solver.critTemp = get(solver.critTempEditBox,'String');
        solver.critPressure = get(solver.critPressureEditBox,'String');
        %Gives errror messages if no number is input
        if isempty(str2num(solver.critPressureEditBox.String)) | str2num(solver.critPressureEditBox.String) < 0
            msgbox('Insert a valid critical pressure!');
        elseif isempty(str2num(solver.critTempEditBox.String)) | str2num(solver.critTempEditBox.String) < 0
            msgbox('Insert a valid critical temperature!');
        elseif isempty(str2num(solver.pressureEditBox.String)) | str2num(solver.pressureEditBox.String) < 0;
            msgbox('Insert a valid Temperature');
        elseif isempty(str2num(solver.volume2EditBox.String)) | str2num(solver.volume2EditBox.String) < 0;
            msgbox('Insert a valid Specific Volume');
        else
    %changes the critTemp and critPressure from strings to numbers
            solver.critTemp = str2num(solver.critTemp);
            solver.critPressure = str2num(solver.critPressure);
            
            a = (27*R^2*solver.critTemp^2)/(64*solver.critPressure);
            b = (R*solver.critTemp)/(8*solver.critPressure);

            specificVol = get(solver.volume2EditBox,'String');
            specificVol = str2num(specificVol);
            
            iPressure = get(solver.pressureEditBox,'String');
            iPressure = str2num(iPressure);
            
            fTemperature = (specificVol - b)*(iPressure + (a/specificVol^2))/R;
            set(solver.temperatureValue,'String',num2str(fTemperature));
        end
    end
end