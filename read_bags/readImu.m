function imu = readImu(bag, topic,start_time,finish_time)

% imu_raw = bag.readAll(topic);
imu_raw = select(bag,'Topic',topic,'Time',[bag.StartTime+start_time bag.StartTime+finish_time]);
imu_raw = readMessages(imu_raw,'DataFormat','struct');
sz = length(imu_raw);

imu.t = zeros(1, sz);
imu.i = zeros(1, sz);
imu.a = zeros(3, sz);
imu.w = zeros(3, sz);
imu.q = zeros(4, sz);

for i=1:sz
   imu.t(i) = timestampFromHeader(imu_raw{i}.Header);
   imu.i(i) = imu_raw{i}.Header.Seq;
   a_tmp = struct2cell(imu_raw{i}.LinearAcceleration);   
   imu.a(:,i) = cell2mat(a_tmp(2:end));
   
   w_tmp = struct2cell(imu_raw{i}.AngularVelocity);      
   imu.w(:,i) = cell2mat(w_tmp(2:end));
   
   q_tmp = struct2cell(imu_raw{i}.Orientation);   
   imu.q(:,i) =cell2mat(q_tmp(2:end));
end