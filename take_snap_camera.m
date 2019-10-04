clc
clear

% import matlab.net.*
% import matlab.net.http.*
% r = RequestMessage;
% uri = URI('https://www.mathworks.com/support/contact_us');
% resp = send(r,uri);
% status = resp.StatusCode


% lectura de imagen y subirla a un url
% data = imread('logo.jpg');
% imshow(data);
% url = 'https://teamextreme.000webhostapp.com/AndroidFileUpload/fileUpload.php';
% webwrite(url,data);

foto = true;
mensaje_enviado = false;
while foto == true
        api = 'https://d3d9894e.ngrok.io/movimiento';
        url = [api ''];
        options = weboptions('ContentType','text');
        data = webread(url,options);
        pause(4);
        x = data(35:44);
        if x == 'tomar foto'
            foto = false;
            disp("Pet detected ... ");
        else
            disp("Standby for pet detection ... ");
        end            
    if foto == false
        %toma de foto de camara ip
        cam = ipcam('http://10.65.253.242:8080/video');
        %cam = ipcam('http://192.168.87.101:8080/video');
        preview(cam)
        img = snapshot(cam);
        disp("Taking pet snapshot ... ");
        closePreview(cam)
        clear cam
        img = imresize(img, 0.25);
        figure; imshow(img)
        imwrite(img,'C:\xampp\htdocs\dashboard\images\foto.jpg');
        disp("Snapshot saved... ");
        replaceLine = 5;
        % editar index html para enviar mensaje
        myformat = '%c';
        newData = '<p>Snapshot saved...<p>'; 
        mensaje_enviado = true;
        fileID = fopen('index.html','r+');
        for k=1:(replaceLine-1);
           fgetl(fileID);
        end
        fseek(fileID,0,'cof');
        fprintf(fileID, myformat, newData);
        fclose(fileID);
        %type index.html
    end
    
    if mensaje_enviado == true
        pause(10)
    % editar index html para borrar mensaje enviado
        myformat = '%c';
        newData = '                       ';
        fileID = fopen('index.html','r+');
        for k=1:(replaceLine-1);
           fgetl(fileID);
        end
        fseek(fileID,0,'cof');
        fprintf(fileID, myformat, newData);
        fclose(fileID);
        disp("Message deleted ... ");
        %type index.html
    end
end


