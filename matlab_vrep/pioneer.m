sim=remApi('remoteApi');
sim.simxFinish(-1);
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);
var=readfis('article_fuzzy.fis');

if (clientID>-1)
    disp('Connected')
    
    %Handle
    [returnCode,left_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
    [returnCode,right_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',sim.simx_opmode_blocking);
    [returnCode,front_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor4',sim.simx_opmode_blocking);
    [returnCode,right_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor6',sim.simx_opmode_blocking);
    [returnCode,left_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor3',sim.simx_opmode_blocking);
    
    [returnCode,detectionStatefront,detectedPointfront,werf,rerf]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionStateright,detectedPointright,werr,rerr]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionStateleft,detectedPointleft,werl,rerl]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_streaming);
    
    
    
 
    %Other Code
    
   k = 0 ;
   while true
    
    %for i=1:50
       [returnCode,detectionStatefront,detectedPointfront,werf,rerf]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_buffer);
       [returnCode,detectionStateleft,detectedPointleft,werl,rerl]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_buffer);
       [returnCode,detectionStateright,detectedPointright,werr,rerr]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_buffer);
       left = (norm(detectedPointleft));
       right = (norm(detectedPointright));
       front = (norm(detectedPointfront));
       
       leftstate = detectionStateleft;
       rightstate = detectionStateright;
       frontstate = detectionStatefront;
       
       front;
       left;
       right;
       
       if(front>1)
          front=1;
       end
       if(left>1 || leftstate==0)
           left=1;
       end
       if(right>1 || rightstate==0)
           right=1;
       end
       
       disp("L")
       disp(leftstate)
       disp(left)
       disp("R")
       disp(rightstate)
       disp(right)
       disp("M")
       disp(frontstate)
       disp(front)
           
    %end
        
    output=evalfis([left,front,right],var);
    

    [returnCode]=sim.simxSetJointTargetVelocity(clientID,left_Motor,output(1,1),sim.simx_opmode_blocking);
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,right_Motor,output(1,2),sim.simx_opmode_blocking);
    pause(0.2);
    k = k + 1 ;
    if(output(1,1)==0&&output(1,2)==0)
        break;
    end
   end
    sim.simxFinish(-1);
end

sim.delete();
   