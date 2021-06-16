%% real images (from DRP)

folder_loc =  '../matlab_volumes_real'
%
output_loc = [folder_loc  '_tiff'];
images = dir([folder_loc '/*.mat']);

for i=1:numel(images)
   name =  images(i).name(1:end-4);
   im = getfield(load([images(i).folder '/' images(i).name]), 'new_im');
   Vol2Tiff(im, output_loc, name)
end


% Get MFP
tiff_dir = output_loc;
mfp_loc = '../mfp_real';
sim_geom_loc = '../domains_real';


parfor i=1:numel(images)
   sample_name =  images(i).name(1:end-4)
   domains_4sim(sample_name, tiff_dir, mfp_loc, sim_geom_loc);
end