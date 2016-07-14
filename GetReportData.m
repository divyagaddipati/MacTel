function GetReportData(images, ar_ab, ar_n, r, file_ab, file_n, imagefile_path, answer)

% Generating Report
makeDOMCompilable;

import mlreportgen.dom.*
rpt_type = 'docx';
fname_report = answer{1};
doc = Document(fullfile('./Reports',fname_report),rpt_type); %Create an empty pdf document

paraObj = Paragraph('NOTE: Values of the areas below are in pixels');
paraObj.Style = {Italic};
append(doc, paraObj); % Append paragraph to document
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Adding the areas of abnormal images to the document

paraObj = Paragraph('Area in abnormal eye for the patient(in pixels)');
paraObj.Style = {Bold};
append(doc, paraObj); % Append paragraph to document
for i = 1 : length(ar_ab)
    para_obj = Paragraph(sprintf('%s = %f',file_ab{i},ar_ab(i)));
    append(doc,para_obj);
end

paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document


%% Adding the areas of normal images to the document

paraObj = Paragraph('Area in normal eye for the patient(in pixels)');
paraObj.Style = {Bold};
append(doc, paraObj); % Append paragraph to document
for i = 1 : length(ar_n)
    para_obj2 = Paragraph(sprintf('%s = %f',file_n{i},ar_n(i)));
    append(doc,para_obj2);
end

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Adding the ratios of the areas to the document

paraObj = Paragraph('Ratio of the areas of abnormal to normal for the patient');
paraObj.Style = {Bold};
append(doc, paraObj); % Append paragraph to document
for i = 1 : length(r{1})
    para_obj1 = Paragraph(sprintf('%s = %f',file_n{i},r{1}(i)));
    append(doc,para_obj1);
end

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Insert an image
for i = 1 : length(file_ab)
    t = strtok(file_ab{i},'.');
    paraObj = Paragraph(sprintf('Area of: %s',t));
    append(doc, paraObj);
    imageObj = Image(fullfile(imagefile_path, 'Images', file_n{i})); % Create an image object
    append(doc,imageObj);
end

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Insert an image
for i = 1 : length(file_n)
    t = strtok(file_n{i},'.');
    paraObj = Paragraph(sprintf('Area of: %s',t));
    append(doc, paraObj);
    imageObj = Image(fullfile(imagefile_path, '\Images', file_n{i})); % Create an image object
    
    append(doc,imageObj);
end


%% Add a Paragraph

paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Close and view the report

close(doc); % Close the document and write to disk
rptview(doc.OutputPath,'docx'); % Open document in in-built PDF viewer

end
