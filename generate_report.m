function images = generate_report(files_ab, files_n, folder, answer)

p = 1; t = 1;

%% Abnormal

for i = 1:length(files_ab)

    file_name = files_ab{3}; % Superficial retina image
    fname=fullfile(folder,file_name);
    im_ab = imread(fname);
    if size(im_ab,1) ~= 352 && size(im_ab,2) ~= 352 
        im_ab = imresize(im_ab, [352 352]);
    end
    im_ab2 = uint8(zeros(size(im_ab))); % Median filtering to remove noise
    im_ab2(:,:,1) = medfilt2(im_ab(:,:,1), [3 3]);
    im_ab2(:,:,2) = medfilt2(im_ab(:,:,2), [3 3]);
    im_ab2(:,:,3) = medfilt2(im_ab(:,:,3), [3 3]);
    im_ab = im_ab2;
    
    % Finding point of intersection of the horizontal and vertical line in
    % the image
    P = POI(im_ab);
    r_ab_init = P(1); c_ab_init = P(2);
    
    m = 1;
    % Finding the point of intersection in all the images in the folder
    for j=1:length(files_ab)
        fname1=fullfile(folder,files_ab{j});
        image_path = fullfile(folder, '\Images', files_ab{j});
        im = imread(fname1);
        im_ab2 = uint8(zeros(size(im))); % Median filtering to remove noise
        im_ab2(:,:,1) = medfilt2(im(:,:,1), [3 3]);
        im_ab2(:,:,2) = medfilt2(im(:,:,2), [3 3]);
        im_ab2(:,:,3) = medfilt2(im(:,:,3), [3 3]);
        im = im_ab2;
        P = POI(im); % Point of intersection
        
        if ~isempty(P)
            r_ab = P(1); c_ab = P(2);
        else
            r_ab = r_ab_init; c_ab = c_ab_init;
        end
        
        imc1 = uint8(zeros(size(im)));
        % Taking a patch around the point of intersection
        imc1(c_ab-60:c_ab+60,r_ab-60:r_ab+60,:) = im(c_ab-60:c_ab+60,r_ab-60:r_ab+60,:);
        imc_bw = im2bw(imc1, graythresh(imc1));
        imwrite(imc_bw, image_path); % Saving the image
            
        images{t} = imc_bw;
        t = t + 1;
        ar_ab(p,m) = bwarea(imc_bw);
        m = m+1;
        clear r_ab; clear c_ab; clear fname1; clear imc1;      
    end
    
%%     Normal
    
    file_name = files_n{3}; % Superficial retina image
    fname=fullfile(folder,file_name);
    im_n = imread(fname);
    if size(im_n,1) ~= 352 && size(im_n,2) ~= 352 
        im_n = imresize(im_n, [352 352]);
    end
    im_n2 = uint8(zeros(size(im_n))); % Median filtering to remove noise
    im_n2(:,:,1) = medfilt2(im_n(:,:,1), [2 2]);
    im_n2(:,:,2) = medfilt2(im_n(:,:,2), [2 2]);
    im_n2(:,:,3) = medfilt2(im_n(:,:,3), [2 2]);
    im_n = im_n2; 
    
    P = POI(im_n);
    r_n_init = P(1); c_n_init = P(2);
    m_n = 1;
    for j=1:length(files_n)
        fname1=fullfile(folder,files_n{j});
        image_path_n = fullfile(folder, '\Images', files_n{j});
        im = imread(fname1);
        if size(im,1) ~= 352 && size(im,2) ~= 352 
            im = imresize(im, [352 352]);
        end
        im_n2 = uint8(zeros(size(im))); % Median filtering to remove noise
        im_n2(:,:,1) = medfilt2(im(:,:,1), [3 3]);
        im_n2(:,:,2) = medfilt2(im(:,:,2), [3 3]);
        im_n2(:,:,3) = medfilt2(im(:,:,3), [3 3]);
        im = im_n2;
        P = POI(im);
        if ~isempty(P)
            r_n = P(1); c_n = P(2);
        else
            r_n = r_n_init; c_n = c_n_init;
        end
        imc1 = uint8(zeros(size(im)));
        % Taking a patch around the point of intersection
        imc1(c_n-60:c_n+60,r_n-60:r_n+60,:) = im(c_n-60:c_n+60,r_n-60:r_n+60,:);
        imc_bw = im2bw(imc1, graythresh(imc1));
        imwrite(imc_bw, image_path_n);
            
        images{t} = imc_bw;
        t = t + 1;
        ar_n(p,m_n) = bwarea(imc_bw);
        m_n = m_n+1;
        clear r_ab; clear c_ab; clear fname1; clear imc1;
    end
end

r{1,:} = ar_ab./ar_n; % Ratio of abnormal to normal

GetReportData(images, ar_ab, ar_n, r, files_ab, files_n, folder, answer);