local table_concat = table.concat
local ngx_re_gsub = ngx.re.gsub
local ngx_re_find = ngx.re.find
local ngx_var = ngx.var

local regex_pattern = ngx_var.domain_name

local chunk, eof = ngx.arg[1], ngx.arg[2]
local buffer = ngx.ctx.buffer
if not buffer then
    buffer = {}
    ngx.ctx.buffer = buffer
end

if chunk ~= "" then
    buffer[#buffer + 1] = chunk
    ngx.arg[1] = nil
end

if eof then
    local whole = table_concat(buffer)
    whole = ngx_re_gsub(whole, regex_pattern, ngx_var.server_ip)

    ngx.ctx.buffer = nil
    ngx.arg[1] = whole
end
