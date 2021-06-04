% the following script loads a project downloaded from the Digital Rocks
% Portal and prepares it for simulation

% why in matlab? I don't have a good answer for that question

% considerations: I downloaded the projects that interest me and saved them
% in a folder as $project_number_$sample_number
% ie: this sample
% https://www.digitalrocksportal.org/projects/317/origin_data/1354/
% was saved as 317_01.raw
% (.dat extensions were switched to .raw)

% this code might upset some programmers since there are a lot of
% statements that are repeated several times. Each project is slightly
% different and it comes from different people around the world, so I had
% to make sure that everything looked right before simulating the samples
% (which takes many days in many nodes)

% Some things that happen here:
% make sure that the image is labeled as 0 (pore) and 1 (solid)
% crop to 256^3 and 480^3 (when possible)
% and add 2 empty slices in the z-dir
% this is to fit the BCs
% there are some projects involving more than one phase, so I saved each
% phase in a separete file

% last thing,
% here, we will assume that z is connected and that is is the flow dir

global im_save

im_dir  = 'raw_volumes';
im_save = 'matlab_volumes';


for num=57:57 %project number
    
    if num==10
        im_size = 650;
        fb = fopen([im_dir '/' num2str(num) '_01.raw' ],'r');
        im = reshape(fread(fb,im_size^3), im_size,im_size,im_size)/255;
        save_files(im, num, 1)
    end
    
    if num==16
        im_size = 512;
        for i=1:2
            fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
            im = reshape(fread(fb,im_size^3), im_size,im_size,im_size);
            save_files(im, num, i)
        end
    end
    
    
    if num==31
        im_size = [800 220 800];
        for i=1:4
            fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
            im = reshape(fread(fb,prod(im_size)), im_size)/255;
            im = padarray(im, [0,580/2,0],1,'both');
            save_files(im, num, i)
        end
    end
    
    
    if num==57
        for i=1:7
            im_size = [480 480 480];
            fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
            im = reshape(fread(fb,prod(im_size)), im_size)/3;
            save_files(im, num, i)
        end
    end
    
    
    
    if num==58
        im_size = [1000 1000 1001];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size)/9;
        save_files(im, num, 1)
    end
    
    
    if num==69
        im = zeros(255,255,255);
        for i=0:255-1
            im(:,:,i+1) = ~imread( strcat('raw_volumes/69_01/', ...
                                        sprintf('Stack%04d.tif',i ) ) );
        end
        im = padarray(im, [1,1,1],'replicate','pre');
        %im = padarray(im, [1,1,1],'replicate','post'); 
        save_files(im, num, 1)
    end
    
    
    if num==72
        im_size = [1000 1000 1000];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=0;
        im(im==9)=1;
        save_files(im, num, 1)
   
        %% subresolution
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=1;
        im(im==9)=1;
        save_files(im, num, 2)
    end
    
    
    if num==73
        im_size = [501 482 600];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=0;
        im(im==9)=1;
        save_files(im, num, 1)
        
        %% subresolution
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size)), im_size);
        im(im==1)=1;
        im(im==9)=1;
        save_files(im, num, 2)
    end
    

    if num==172
        im_size = [601 594 1311];
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
        im = ~reshape(fread(fb,prod(im_size),'uint16'), im_size);
        save_files(im, num, 1)
        
        
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(2) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size),'uint16'), im_size);
        im_tmp = im;
        im = (~im) + (im_tmp==2);
        save_files(im, num, 2)
        
        fb = fopen([im_dir '/' num2str(num) '_0' num2str(2) '.raw' ],'r');
        im = reshape(fread(fb,prod(im_size),'uint16'), im_size);
        im_tmp = im;
        im = (~im) + (im_tmp==1);
        save_files(im, num, 3)
    end

    if num==276
            im_size = [300 300 300];
            fb = fopen([im_dir '/' num2str(num) '_0' num2str(1) '.raw' ],'r');
            im = reshape(fread(fb,prod(im_size)), im_size);
            save_files(im, num, 1)
    end
    
    if num==317
        im_size = [1000 1000 1000];
        for i=1:11
            fb = fopen([im_dir '/' num2str(num) '_0' num2str(i) '.raw' ],'r');
            im = reshape(fread(fb,prod(im_size)), im_size);
            save_files(im, num, i)
        end
    end
    
    if num==339
        for i=1:4
            im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
            for slice = 2:1094
                im = cat(3, im, ...
                    imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
            end
            
            im = im/255;
            save_files(im, num, i)
        end
    end
    
    
    if num==344
        for i=1:4
            im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
            for slice = 2:1000
                im = cat(3, im, ...
            imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
            end
            
            im_tmp = im;
            im = (~im) + (im==1) + (im==5);
            save_files(im, num, i)
        end
        
        
        
        for i=1:4
            im = imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'], 1);
            for slice = 2:1000
                im = cat(3, im, ...
            imread( [im_dir '/' num2str(num) '_0' num2str(i) '.tif'],slice));
            end
            im_tmp = im;
            im = (~im) + (im==2) + (im==5);
            save_files(im, num, i+4)
        end
        
    end
end


function [] = save_files(im, num, i)
    disp(['Sample ' num2str(num) ' file ' num2str(i)])
    
    if numel(unique(im))>2
        error('The image is not binary')
    end
    
    figure;imagesc(im(:,:,100))
    pause(.1)
    
    crop_size = 256;
    crop_save(crop_size, im, num, i);
    crop_size = 480;
    crop_save(crop_size, im, num, i);  
end


function []=crop_save(crop_size, im, num, i)
    i_shape = size(im);
    if sum( i_shape >= crop_size) == 3
            [new_im, phi] = cut_geom(im, crop_size);
            if phi>0.01
                write_im(new_im, num, i)
            else
                disp('The porosity is lower than 1%')
            end
    else
        disp(['The geometry is too small to crop ' num2str(crop_size)])
    end
end


function [] = write_im(new_im, num, i)
    global im_save
    i_shape = size(new_im);
    x_size  = i_shape(1);
    save([im_save '/' num2str(num) '_0' num2str(i) '_' num2str(x_size)], ...
                                                                'new_im')
end


function [new_im, phi] = cut_geom(im, vol_len)
    i_shape   = size(im);
    
    if sum(i_shape==vol_len)==3
        new_im = im;
    else
        first_len = vol_len/2;
        last_len  = vol_len/2-1;

        new_im = im( fix(i_shape(1)/2)-first_len:fix(i_shape(1)/2)+last_len, ...
                     fix(i_shape(2)/2)-first_len:fix(i_shape(2)/2)+last_len, ...
                     fix(i_shape(3)/2)-first_len:fix(i_shape(3)/2)+last_len );
    end
             
    new_im = padarray(new_im,[0,0,1],0,'both'); % add empty voxels for BCs
    [new_im, phi] = eliminate_isolatedRegions(new_im,6); % erase cul-de-sac pores
end