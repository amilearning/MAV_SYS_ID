function command = readCommandRollPitchYawRateThrust( bag, topic ,start_time,finish_time )

% command_raw = bag.readAll(topic);

command_raw = select(bag,'Time',[bag.StartTime+start_time bag.StartTime+finish_time],'Topic',topic);
command_raw = readMessages(command_raw,'DataFormat','struct');

sz = length(command_raw);

command.t = zeros(1, sz);
command.i = zeros(1,sz);


for i=1:sz
    command.t(i) = timestampFromHeader(command_raw{i}.Header);
    command.i(i) = command_raw{i}.Header.Seq;
    command.roll(:,i) = command_raw{i}.Roll;
    command.pitch(:,i) = command_raw{i}.Pitch;
    command.yaw_rate(:,i) = command_raw{i}.YawRate;
    command.thrust(:,i) = command_raw{i}.Thrust.Z;
end




end
