local headers = ngx.resp.get_headers()

local regex_pattern = ngx.var.domain_name
local yundun_com_pattern = "www.yundun.com"

if type(headers) == "table" then
    local location = headers["Location"]
    if location then
        local new = ngx.re.gsub(location, regex_pattern, ngx.var.server_ip)
        new = ngx.re.gsub(new, yundun_com_pattern, ngx.var.server_ip)
        ngx.header["Location"] = new
    end
end

ngx.header["content-length"] = nil
