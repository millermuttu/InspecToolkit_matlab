function line_plot_category(label, X, category)
%Summary: creates a line plots of data with color according to category
%
% Chemometrics Toolbox
%-------------------------------------------------------------------------
% Robert Bosch GmbH
% Robert-Bosch-Campus 1
% 71272 Renningen
%-------------------------------------------------------------------------
%
% function syntax:
% line_plot_category(label, X, category)
%
% 
% input parameter:  
%                   label       = label for columns within X
%                   X           = measruement data
%                   category    = category used for differentiation
% 

%% initialize plot
C = unique(category(:,1));
colormap = [lines;colorcube;colorcube;colorcube;colorcube];

% if data is categorized by several categories this should be a subplot
if(size(category,2)>1)
    sub1 = subplot(1,5,[1:4]);
end


%% make actual plots
% figure
%subplot(1,5,[1:4])
hold on
if(isnumeric(category))
    for i = 1:size(X,1)
        assigning = (C==category(i,1));
        [row,~] = find(assigning == 1);
        plot(label, X(i,:), 'color', colormap(row,:));
    end
else
    for i = 1:size(X,1)
        assigning = strcmp(C,category(i,1));
        [row,~] = find(assigning == 1);
        plot(label, X(i,:), 'color', colormap(row,:));
    end
end
legend('off')

%% Create dummy plots to get legend
hold on;
h = zeros(size(C,1),1);
for i = 1:size(C,1)
    h(i) = plot(label, X(i,:), 'color', colormap(i,:));
end

if(isnumeric(category))
    legend(h, num2str(C));
else
    legend(h, C);
end

set(gcf,'Color',[1,1,1]);

% xlabel('Wavelength','fontsize',16);
% ylabel('Raw ADC','fontsize',16);
% title('Feasibility of Lactose in UHT Milk','fontsize',18);

% create UI if more than one type of categorization can be applied
if(size(category,2)>1)
    cat_options = cell(size(category,2));
    for i = 1:size(category,2)
        cat_options{i} = ['Option ', num2str(i)];
    end
    % get position of subplot 1
    pos = get(sub1, 'position');
    
    cat_txt = uicontrol('Style','text',...
        'BackgroundColor', [1 1 1],...
        'Units', 'normalized',...
        'HorizontalAlignment','left',...
        'FontSize', 12 ,... 
        'Position',[pos(1)+.65 pos(2)+.3 .15 .1],...
        'String','Choose the categories for colorencoding');

    Category_popup = uicontrol('Style', 'popup',...
           'String', cat_options,...
           'Units', 'normalized',...
           'Position', [pos(1)+.65 pos(2)+.2 .15 .05],...
           'Tag','Category_popup',...
           'UserData', 1,...
           'Callback', @setCategory);
       
    % Create push button to apply
    apply_btn = uicontrol('Style', 'pushbutton',...
        'String', 'Apply',...
        'Units', 'normalized',...
        'Position', [pos(1)+.65 pos(2) .15 .05],...
        'Callback', @applySubplot1);
    
    
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    % Create UI for selecting a Spectrum

pos = get(sub1, 'position');

btn = uicontrol('Style', 'pushbutton',...
    'String', 'Select a Spectrum',...
    'Units', 'normalized',...
    'FontSize', 12 ,... 
    'Position', [pos(1) pos(2)-.2 .3 .05],...
    'Callback', @getSpectrumNumber);

pos_txt = uicontrol('Style','text',...
    'BackgroundColor', [1 1 1],...
    'Units', 'normalized',...
    'HorizontalAlignment','left',...
    'Tag','pos_txt',...
    'FontSize', 12 ,... 
    'Position',[pos(1)+.33 pos(2)-.2 .5 .05],...
    'Visible', 'off',...
    'String','You chose Spectrum ');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

end

%% Make figure visible after adding all components
f.Visible = 'on';

%% Callback functions that control which category is used for colorencoding
function setCategory(source, event)
    source.UserData = source.Value;
end

function applySubplot1(source, event)
    
    h_Category = findobj('Tag','Category_popup');
    cat_ind = h_Category.UserData;
    
    Cat = unique(category(:,cat_ind));
    subplot(1,5,[1:4]);
    hold on;
    
    % make actual plots
    if(isnumeric(category))
        for k = 1:size(X,1)
            plot(label, X(k,:), 'color', colormap(Cat == category(k,cat_ind),:));
        end
    else
        for k = 1:size(X,1)
            plot(label, X(k,:), 'color', colormap(strcmp(Cat, category(k,cat_ind)),:));
        end
    end
    hold on;
    legend('off')
    
    % Create dummy plots to get legend
    h = zeros(size(Cat,1),1);
    for k = 1:size(Cat,1)
        h(k) = plot(label, X(k,:), 'color', colormap(k,:));
    end
    xlabel('wavelength');
    ylabel('Reflectance');
    
    if(isnumeric(category))
        legend(h, num2str(Cat));
    else
        legend(h, Cat);
    end

end
hold off
end