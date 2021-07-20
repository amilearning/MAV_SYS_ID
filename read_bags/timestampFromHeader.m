function timestamp = timestampFromHeader(header)

timestamp = double(header.Stamp.Sec) + double(header.Stamp.Nsec)*1e-9;