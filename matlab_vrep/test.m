sim=remApi('remoteApi');
sim.simxFinish(-1);
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);
var=readfis('3sensor.fis');

if (clientID>-1)
    disp('Connected')
    
    %Handle
    [returnCode,left_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
    [returnCode,right_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',sim.simx_opmode_blocking);
    [returnCode,front_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor4',sim.simx_opmode_blocking);
    [returnCode,right_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor6',sim.simx_opmode_blocking);
    [returnCode,left_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor3',sim.simx_opmode_blocking);
    
    [returnCode,detectionStatefront,detectedPointfront,werf,]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionStateright,detectedPointright,werr,rerr]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionStateleft,detectedPointleft,werl,rerl]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_streaming);
    
    
    
 
    %Other Code
    
   k = 0 ;
   while true
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,left_Motor,0.1,sim.simx_opmode_blocking);
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,right_Motor,0.1,sim.simx_opmode_blocking);
    for i=1:50
       [returnCode,detectionStatefront,detectedPointfront,~,~]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_buffer);
       [returnCode,detectionStateleft,detectedPointleft,~,~]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_buffer);
       [returnCode,detectionStateright,detectedPointright,~,~]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_buffer);
       left = (norm(detectedPointleft));
       right = (norm(detectedPointright));
       front = (norm(detectedPointfront));
       disp("L")
       disp(left)
       disp("R")
       disp(right)
       disp("M")
       disp(front)
       pause(2)
    end
        
    output=evalfis([left,front,right],var);
    
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,left_Motor,0.7,sim.simx_opmode_blocking);
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,right_Motor,0.7,sim.simx_opmode_blocking);
    pause(1);
    k = k + 1 ;
   end
    sim.simxFinish(-1);
end

sim.delete();
   