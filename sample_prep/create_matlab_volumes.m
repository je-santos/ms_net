% the following script loads a project downloaded from the Digital Rocks
% Portal and prepares it for simulation

% why in matlab? I don't have a good answer for that question

% considerations: I downloaded the projects that interest me and saved them
% in a folder as $project_number_$sample_number
% ie: this sample 
% https://www.digitalrocksportal.org/projects/317/origin_data/1354/
% was saved as 317_01.raw
% (.dat extensions were switched to raw)

% this code might upset some programmers since there are a lot of
% statements that are repeated several times. Each project is slightly
% different and it comes from different people around the world, so I had 
% to make sure that everything looked right before simulating the samples
% (which takes many days in many nodes)

% Some things that happen here:
% make sure that the image is labeled as 0 (pore) and 1 (solid) 
% crop to (256-2)*256**2 and (480-2)*256**2 (when possible)
% this is to fit the BCs
% there are some projects involving more than one phase, so I saved each 
% phase in a separete file

% last thing,
% here, we will assume that z is connected and that is is the flow dir

clear all

num = 344;  % project number
im_dir  = 'raw_volumes';
im_save = 'matlab_volumes';



if num==10
    im_size = 650;
    fb = fopen([im_dir '/' num2str(num) '_01.raw' ],'r');
    im = reshape(fread(fb,im_size^3), im_size,im_size,im_size)/255;
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_01_256'], 'im_256')
    save([im_save '/' num2str(num) '_01_480'], 'im_480')
end


if num==16
    
    im_size = 512;
    fb = fopen([im_dir '/' num2str(num) '_01.raw' ],'r');
    im = reshape(fread(fb,im_size^3), im_size,im_size,im_size);
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_01_256'], 'im_256')
    save([im_save '/' num2str(num) '_01_480'], 'im_480')
    
    %%
    fb = fopen([im_dir '/' num2str(num) '_02.raw' ],'r');
    im = reshape(fread(fb,im_size^3), im_size,im_size,im_size);
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_02_256'], 'im_256')
    save([im_save '/' num2str(num) '_02_480'], 'im_480')
end


if num==31
    
    im_size = [800 220 800];
    fb = fopen([im_dir '/' num2str(num) '_01.raw' ],'r');
    im = reshape(fread(fb,prod(im_size)), im_size)/255;
    im = padarray(im, [0,580/2,0],1,'both');
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_01_256'], 'im_256')
    save([im_save '/' num2str(num) '_01_480'], 'im_480')
    
    %%
    im_size = [800 220 800];
    fb = fopen([im_dir '/' num2str(num) '_02.raw' ],'r');
    im = reshape(fread(fb,prod(im_size)), im_size)/255;
    im = padarray(im, [0,580/2,0],1,'both');
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_02_256'], 'im_256')
    save([im_save '/' num2str(num) '_02_480'], 'im_480')
    
    %%
    im_size = [800 220 800];
    fb = fopen([im_dir '/' num2str(num) '_03.raw' ],'r');
    im = reshape(fread(fb,prod(im_size)), im_size)/255;
    im = padarray(im, [0,580/2,0],1,'both');
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_03_256'], 'im_256')
    save([im_save '/' num2str(num) '_03_480'], 'im_480')
    
    %%
    im_size = [800 220 800];
    fb = fopen([im_dir '/' num2str(num) '_04.raw' ],'r');
    im = reshape(fread(fb,prod(im_size)), im_size)/255;
    im = padarray(im, [0,580/2,0],1,'both');
    unique(im)
    i_shape = size(im);
    
    im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                 fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                 fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
             
    im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                 fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                 fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
             
    save([im_save '/' num2str(num) '_04_256'], 'im_256')
    save([im_save '/' num2str(num) '_04_480'], 'im_480')
    
    
end


if num==57
    for i=1:7
        im_size = [480 480 480];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size)/3;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     :,:);

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
end



if num==58
    for i=1:1
        im_size = [1000 1000 1001];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size)/9;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
end


if num==69
    im = zeros(255,255,255);
    for i=0:255-1
        im(:,:,i+1) = ~imread( strcat('raw_volumes/69_01/', ...
                               sprintf('Stack%04d.tif',i ) ) );
    end
    im = padarray(im, [0,1,1],'replicate','pre');
    unique(im)
    
     im_256 = im( 2:end, :,:);
     save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
end


if num==72
    for i=1:1
        im_size = [1000 1000 1000];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
       
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=0;
        im(im==9)=1;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
    
    for i=1:1
        im_size = [1000 1000 1000];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
       
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=1;
        im(im==9)=1;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(2) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(2) '_480'], 'im_480')
    end
end


if num==73
    for i=1:1
        im_size = [501 482 600];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
       
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=0;
        im(im==9)=1;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
    
    for i=1:1
        
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
       
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=1;
        im(im==9)=1;
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(2) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(2) '_480'], 'im_480')
    end
end



if num==172
    for i=1:1
        im_size = [601 594 1311];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = ~reshape(fread(fb,prod(im_size),'uint16'), im_size);
        
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
    
    for i=2:2
        im_size = [601 594 1311];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size),'uint16'), im_size);
        
        im_tmp = im;
        im = (~im) + (im_tmp==2);
        

        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
    
    for i=2:2
        im_size = [601 594 1311];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size),'uint16'), im_size);
        
        im_tmp = im;
        im = (~im) + (im_tmp==1);
        
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(3) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(3) '_480'], 'im_480')
    end
    
end



if num==276
    for i=1:1
        im_size = [300 300 300];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
    end
end


if num==317
    for i=10:11
        im_size = [1000 1000 1000];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        %im = padarray(im, [0,580/2,0],1,'both');
        unique(im)
        i_shape = size(im);
        
        %figure;imagesc(im(:,:,500))

        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
                     fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
                     fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );

        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
                     fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
                     fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );

        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
end


if num==339
    
    for i=1:4
        im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
        for slice = 2:1094
            %disp(slice)
            im = cat(3, im, ...
                imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
        end
        
        im = im/255;
        unique(im)
        figure;imagesc(im(:,:,600))
        i_shape = size(im);
        %im = padarray(im, [0,1,1],'replicate','pre');
        
        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
            fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
            fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
        
        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
            fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
            fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
        
        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
end



if num==344
    
    for i=1:4
        im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
        for slice = 2:1000
            %disp(slice)
            im = cat(3, im, ...
                imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
        end
        
        im_tmp = im;
        im = (~im) + (im==1) + (im==5);
        
        unique(im)
        figure;imagesc(im(:,:,600))
        %im = padarray(im, [0,1,1],'replicate','pre');
        
        i_shape = size(im);
        
        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
            fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
            fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
        
        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
            fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
            fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
        
        save([im_save '/' num2str(num) '_0' num2str(i) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i) '_480'], 'im_480')
    end
    
    
    
    for i=1:4
        im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
        for slice = 2:1000
            %disp(slice)
            im = cat(3, im, ...
                imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
        end
        
        im_tmp = im;
        im = (~im) + (im==2) + (im==5);
        
        unique(im)
        figure;imagesc(im(:,:,600))
        %im = padarray(im, [0,1,1],'replicate','pre');
        
        i_shape = size(im);
        
        im_256 = im( fix(i_shape(1)/2)-127:fix(i_shape(1)/2)+126, ...
            fix(i_shape(2)/2)-128:fix(i_shape(2)/2)+127, ...
            fix(i_shape(3)/2)-128:fix(i_shape(3)/2)+127 );
        
        im_480 = im( fix(i_shape(1)/2)-239:fix(i_shape(1)/2)+238, ...
            fix(i_shape(2)/2)-240:fix(i_shape(2)/2)+239, ...
            fix(i_shape(3)/2)-240:fix(i_shape(3)/2)+239 );
        
        save([im_save '/' num2str(num) '_0' num2str(i+4) '_256'], 'im_256')
        save([im_save '/' num2str(num) '_0' num2str(i+4) '_480'], 'im_480')
    end
    
    
    
    
end
